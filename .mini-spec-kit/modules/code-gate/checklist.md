# Code Gate Checklist

> All items start as `[ ]`. Check items only during Reconcile after the command or inspection has passed.

## REQ-009: Phase Commands And Skills Use Hard Gates

**Implementation**:
- [ ] Update phase command and skill instructions so each phase runs or documents the matching hard gate before proceeding.

**Verification**:
- [ ] `rg -n "minispec-gate.sh --phase (specify|plan|checklist|analyze|before-implement|after-implement|final)" .claude/commands .agents/skills templates` shows gate usage across phase instructions.
- [ ] `rg -n "before-implement|--phase 5" .claude/commands/analyze.md .agents/skills/speckit-analyze/SKILL.md README.md README.zh-CN.md templates/CLAUDE.md templates/AGENTS.md` shows no Analyze-phase before-implement instruction.

## REQ-010: Final Completion Semantics

**Implementation**:
- [x] Update English and Chinese READMEs to state that complete means the final gate passes.

**Verification**:
- [x] `rg -n "final gate|--phase final|complete means|完成.*final" README.md README.zh-CN.md` shows final-complete semantics in both docs.

## REQ-011: Init Installs Workflow Context

**Implementation**:
- [x] Ensure `init-mini-speckit.sh` installs required context files and executable gate scripts into target projects.

**Verification**:
- [x] `tmpdir="$(mktemp -d)" && mkdir -p "$tmpdir/project" && ./scripts/init-mini-speckit.sh "$tmpdir/project" && test -f "$tmpdir/project/.mini-spec-kit/project-constraints.md" && test -f "$tmpdir/project/.mini-spec-kit/project-spec.md" && test -f "$tmpdir/project/.github/copilot-instructions.md" && test -f "$tmpdir/project/.claude/commands/specify.md" && test -f "$tmpdir/project/.agents/skills/speckit-specify/SKILL.md" && test -x "$tmpdir/project/scripts/check-phase-prereqs.sh" && test -x "$tmpdir/project/scripts/minispec-gate.sh" && test -f "$tmpdir/project/AGENTS.md" && test -f "$tmpdir/project/CLAUDE.md"`

## REQ-012: Example Module Is Open

**Implementation**:
- [x] Mark `example-module` as a pre-implementation/open example and exclude it from final-complete semantics.

**Verification**:
- [x] `rg -n "pre-implementation|open example|not final-complete|not complete|未完成|开放示例" .mini-spec-kit/modules/example-module README.md README.zh-CN.md` shows the example status.
- [x] `./scripts/minispec-gate.sh --phase final --module example-module --project-root .` fails.

## REQ-013: Final Gate Closed-Loop Validation

**Implementation**:
- [x] Strengthen `scripts/minispec-gate.sh --phase final` so it validates all closed-loop artifacts.

**Verification**:
- [x] `bash -n scripts/*.sh` passes.
- [x] `./scripts/minispec-gate.sh --phase analyze --module code-gate --project-root .` passes.
- [x] `./scripts/minispec-gate.sh --phase before-implement --module code-gate --project-root .` passes before implementation.
- [ ] `./scripts/minispec-gate.sh --phase final --module code-gate --project-root .` passes after Reconcile.
