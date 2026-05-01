#!/usr/bin/env bash
set -euo pipefail

PHASE=""
MODULE=""
PROJECT_ROOT="."

usage() {
  echo "Usage: $0 --phase <specify|plan|checklist|analyze|before-implement|after-implement|reconcile|final> --module <name> [--project-root <path>]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --phase) PHASE="${2:-}"; shift 2 ;;
    --module) MODULE="${2:-}"; shift 2 ;;
    --project-root) PROJECT_ROOT="${2:-}"; shift 2 ;;
    *) usage ;;
  esac
done

[[ -z "$PHASE" || -z "$MODULE" ]] && usage

PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"
MODULE_DIR="$PROJECT_ROOT/.mini-spec-kit/modules/$MODULE"
SPEC_FILE="$MODULE_DIR/spec.md"
PLAN_FILE="$MODULE_DIR/plan.md"
CHECKLIST_FILE="$MODULE_DIR/checklist.md"
GATE_FILE="$MODULE_DIR/gate.md"
CHANGELOG_FILE="$MODULE_DIR/changelog.md"
VERIFY_LOG="$MODULE_DIR/verify.log"
GATE_HISTORY_LOG="$MODULE_DIR/gate-history.log"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

pass() {
  echo "PASS: $1"
  exit 0
}

need_file() {
  [[ -f "$1" ]] || fail "Missing file: $1"
}

need_section() {
  local file="$1"
  local section="$2"
  grep -qF "$section" "$file" || fail "$file missing section: $section"
}

need_req_ids() {
  grep -qE 'REQ-[0-9]+' "$1" || fail "$1 has no REQ-XXX items"
}

need_unchecked_checklist() {
  need_file "$CHECKLIST_FILE"
  grep -qE '^[[:space:]]*- \[ \]' "$CHECKLIST_FILE" || fail "$CHECKLIST_FILE has no unchecked checklist items"
  if grep -qiE '^[[:space:]]*- \[x\]' "$CHECKLIST_FILE"; then
    fail "$CHECKLIST_FILE has checked items before Reconcile"
  fi
  grep -qE '\*\*Verification\*\*:|### Verification' "$CHECKLIST_FILE" || fail "$CHECKLIST_FILE has no Verification block"
}

need_checklist_structure() {
  need_file "$CHECKLIST_FILE"
  grep -qE '^[[:space:]]*- \[[ xX]\]' "$CHECKLIST_FILE" || fail "$CHECKLIST_FILE has no checklist items"
  grep -qE '\*\*Verification\*\*:|### Verification' "$CHECKLIST_FILE" || fail "$CHECKLIST_FILE has no Verification block"
}

need_checked_checklist() {
  need_file "$CHECKLIST_FILE"
  if grep -qE '^[[:space:]]*- \[ \]' "$CHECKLIST_FILE"; then
    fail "$CHECKLIST_FILE still has unchecked items"
  fi
  grep -qiE '^[[:space:]]*- \[x\]' "$CHECKLIST_FILE" || fail "$CHECKLIST_FILE has no checked checklist items"
}

need_analysis_pass() {
  need_file "$PLAN_FILE"
  need_section "$PLAN_FILE" "## Analysis Report"
  awk '
    /^## Analysis Report/ { in_report=1; next }
    in_report && /^## / { in_report=0 }
    in_report && /PASS/ { pass=1 }
    END { exit pass ? 0 : 1 }
  ' "$PLAN_FILE" || fail "$PLAN_FILE Analysis Report is not PASS"
  if awk '
    /^## Analysis Report/ { in_report=1; next }
    in_report && /^## / { in_report=0 }
    in_report && tolower($0) ~ /(^|[[:space:]])critical[[:space:]]*(:|-)/ { found=1 }
    END { exit found ? 0 : 1 }
  ' "$PLAN_FILE"; then
    fail "$PLAN_FILE Analysis Report contains CRITICAL issues"
  fi
}

need_gate_file() {
  need_file "$GATE_FILE"
  need_section "$GATE_FILE" "## Workflow Status"
  need_section "$GATE_FILE" "## Gate Status"
  need_section "$GATE_FILE" "## Implement Permission"
  need_section "$GATE_FILE" "## Final Result"
  need_section "$GATE_FILE" "## Blockers"
  need_section "$GATE_FILE" "## History"
}

need_implement_allowed() {
  need_gate_file
  grep -qiE 'Allowed:[[:space:]]*yes' "$GATE_FILE" || fail "$GATE_FILE does not allow Implement"
}

need_git_diff() {
  git -C "$PROJECT_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "$PROJECT_ROOT is not a git work tree"
  if git -C "$PROJECT_ROOT" diff --quiet --exit-code && [[ -z "$(git -C "$PROJECT_ROOT" status --porcelain)" ]]; then
    fail "No git diff found"
  fi
}

need_verify_log() {
  need_file "$VERIFY_LOG"
  grep -qi "PASS" "$VERIFY_LOG" || fail "$VERIFY_LOG has no PASS entry"
}

need_gate_history() {
  need_file "$GATE_HISTORY_LOG"
  grep -qiE 'PASS|DONE|FAIL' "$GATE_HISTORY_LOG" || fail "$GATE_HISTORY_LOG has no gate result entry"
}

need_changelog() {
  need_file "$CHANGELOG_FILE"
  grep -qE '^## [0-9]{4}-[0-9]{2}-[0-9]{2}:' "$CHANGELOG_FILE" || fail "$CHANGELOG_FILE has no dated change entry"
  grep -qE 'REQ-[0-9]+' "$CHANGELOG_FILE" || fail "$CHANGELOG_FILE has no requirement reference"
}

need_final_result() {
  need_gate_file
  grep -qiE 'Status:[[:space:]]*(PASS|DONE)' "$GATE_FILE" || fail "$GATE_FILE Final Result is not PASS or DONE"
}

case "$PHASE" in
  specify)
    need_file "$PROJECT_ROOT/.mini-spec-kit/project-constraints.md"
    need_file "$PROJECT_ROOT/.mini-spec-kit/project-spec.md"
    [[ -d "$MODULE_DIR" ]] || fail "Missing module directory: $MODULE_DIR"
    pass "specify prerequisites satisfied for $MODULE"
    ;;
  plan)
    need_file "$SPEC_FILE"
    need_section "$SPEC_FILE" "## Requirements"
    need_req_ids "$SPEC_FILE"
    pass "plan prerequisites satisfied for $MODULE"
    ;;
  checklist)
    need_file "$SPEC_FILE"
    need_file "$PLAN_FILE"
    need_section "$PLAN_FILE" "## Task List"
    need_req_ids "$PLAN_FILE"
    pass "checklist prerequisites satisfied for $MODULE"
    ;;
  analyze)
    need_file "$SPEC_FILE"
    need_file "$PLAN_FILE"
    need_checklist_structure
    pass "analyze prerequisites satisfied for $MODULE"
    ;;
  before-implement)
    need_file "$SPEC_FILE"
    need_file "$PLAN_FILE"
    need_unchecked_checklist
    need_analysis_pass
    need_implement_allowed
    pass "implement prerequisites satisfied for $MODULE"
    ;;
  after-implement)
    need_file "$SPEC_FILE"
    need_file "$PLAN_FILE"
    need_file "$CHECKLIST_FILE"
    need_analysis_pass
    need_git_diff
    pass "after-implement prerequisites satisfied for $MODULE"
    ;;
  reconcile)
    need_git_diff
    need_file "$SPEC_FILE"
    need_file "$PLAN_FILE"
    need_analysis_pass
    need_checked_checklist
    need_changelog
    need_verify_log
    need_gate_history
    pass "reconcile artifacts satisfied for $MODULE"
    ;;
  final)
    need_git_diff
    need_file "$SPEC_FILE"
    need_file "$PLAN_FILE"
    need_analysis_pass
    need_checked_checklist
    need_changelog
    need_verify_log
    need_gate_history
    need_final_result
    pass "final gate satisfied for $MODULE"
    ;;
  *)
    fail "Unsupported phase: $PHASE"
    ;;
esac
