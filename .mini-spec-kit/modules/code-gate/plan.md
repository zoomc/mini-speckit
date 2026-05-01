# Code Gate Plan

## Phase Status

- [x] Specify: `spec.md` has `## Requirements` with requirement IDs.
- [x] Plan: `plan.md` has `## Task List` with file paths, dependencies, and success criteria.
- [x] Checklist: `checklist.md` generated with unchecked items and verification commands.
- [x] Analyze: `plan.md` has `## Analysis Report` with consistency check.
- [x] Implement: Code and documentation changes completed for REQ-010 through REQ-013; REQ-009 is blocked on `.agents/skills` write permissions.
- [ ] Reconcile: Checklist partially checked, logs updated, changelog updated, and final gate blocked by REQ-009.

## Change Type

- **Type**: Enhancement
- **Reason**: Hard gate enforcement is currently incomplete and some agent instructions conflict with the intended workflow.
- **Impact**: Shell scripts, README files, templates, Claude commands, Codex skills, and module templates.

## Task List

### TASK-001: Correct phase prerequisite semantics
- **Requirement**: REQ-002, REQ-003
- **Files**: `scripts/check-phase-prereqs.sh`
- **Dependencies**: none
- **Success criteria**: The script checks `.mini-spec-kit/modules/<module>` and rejects pre-checked checklist items before Implement.

### TASK-002: Add hard gate script
- **Requirement**: REQ-001, REQ-003, REQ-004, REQ-005, REQ-006
- **Files**: `scripts/minispec-gate.sh`, `scripts/init-mini-speckit.sh`
- **Dependencies**: TASK-001
- **Success criteria**: Supported phases return exit 0/1 based on required artifacts, checklist state, gate files, verification logs, changelog, and git diff.

### TASK-003: Add gate and log conventions to module template
- **Requirement**: REQ-005, REQ-006
- **Files**: `.gitignore`, `.mini-spec-kit/modules/example-module/gate.md`, `.mini-spec-kit/modules/example-module/verify.log`, `.mini-spec-kit/modules/example-module/gate-history.log`, `.mini-spec-kit/modules/example-module/complement.md`, `.mini-spec-kit/project-constraints.md`, `.mini-spec-kit/project-spec.md`, `.github/copilot-instructions.md`
- **Dependencies**: TASK-002
- **Success criteria**: Template documents `gate.md`, `verify.log`, and `gate-history.log` without mixing gate status into business checklist items.

### TASK-004: Update agent docs and commands
- **Requirement**: REQ-001, REQ-003, REQ-007
- **Files**: `README.md`, `README.zh-CN.md`, `templates/CLAUDE.md`, `templates/AGENTS.md`, `.claude/commands/*.md`, `.agents/skills/*/SKILL.md`
- **Dependencies**: TASK-002
- **Success criteria**: Docs consistently require all git-diff-producing work to follow six phases and call the gate scripts; no Hermes-only or dual-session conflict remains.

### TASK-005: Verify scripts and representative gates
- **Requirement**: REQ-004, REQ-007
- **Files**: `scripts/*.sh`, `.mini-spec-kit/modules/example-module/*`, `.mini-spec-kit/modules/code-gate/*`
- **Dependencies**: TASK-001 through TASK-004
- **Success criteria**: `bash -n scripts/*.sh` passes; gate phases are exercised on a test/example module; docs are checked for obvious contradictory checklist guidance.

### TASK-006: Separate Analyze rerun checks from Implement permission
- **Requirement**: REQ-008
- **Files**: `scripts/minispec-gate.sh`, `scripts/check-phase-prereqs.sh`, `.claude/commands/analyze.md`, `README.md`, `README.zh-CN.md`, `templates/CLAUDE.md`, `templates/AGENTS.md`, `.mini-spec-kit/project-constraints.md`, `.mini-spec-kit/project-spec.md`, `.github/copilot-instructions.md`, `.agents/skills/speckit-analyze/SKILL.md`, `.agents/skills/speckit-implement/SKILL.md`
- **Dependencies**: TASK-001 through TASK-005
- **Success criteria**: Analyze gates pass for already reconciled modules with checked checklist items, while before-implement still rejects checked checklist items; Analyze command documentation no longer calls before-implement.

### TASK-007: Require explicit hard gates in phase instructions
- **Requirement**: REQ-009
- **Files**: `.claude/commands/*.md`, `.agents/skills/*/SKILL.md`, `templates/CLAUDE.md`, `templates/AGENTS.md`
- **Dependencies**: TASK-002, TASK-006
- **Success criteria**: Each phase instruction names the correct `minispec-gate.sh --phase ...` command before handing off to the next phase.

### TASK-008: Clarify complete/final meaning in user docs
- **Requirement**: REQ-010
- **Files**: `README.md`, `README.zh-CN.md`
- **Dependencies**: TASK-007
- **Success criteria**: Documentation states that complete means `scripts/minispec-gate.sh --phase final --module <module> --project-root .` passes.

### TASK-009: Verify init installs all required workflow context
- **Requirement**: REQ-011
- **Files**: `scripts/init-mini-speckit.sh`, `README.md`, `README.zh-CN.md`
- **Dependencies**: TASK-007
- **Success criteria**: The init script installs required context directories/files and gate scripts; docs list what gets installed.

### TASK-010: Mark example module as open/pre-implementation
- **Requirement**: REQ-012
- **Files**: `.mini-spec-kit/modules/example-module/spec.md`, `.mini-spec-kit/modules/example-module/plan.md`, `.mini-spec-kit/modules/example-module/checklist.md`, `.mini-spec-kit/modules/example-module/gate.md`, `.mini-spec-kit/modules/example-module/changelog.md`, `.mini-spec-kit/modules/example-module/verify.log`, `.mini-spec-kit/modules/example-module/gate-history.log`, `README.md`, `README.zh-CN.md`
- **Dependencies**: TASK-008
- **Success criteria**: The example module visibly states that it is open/pre-implementation and is not final-complete.

### TASK-011: Strengthen final gate closed-loop validation
- **Requirement**: REQ-013
- **Files**: `scripts/minispec-gate.sh`, `.claude/commands/reconcile.md`, `.agents/skills/speckit-reconcile/SKILL.md`, `README.md`, `README.zh-CN.md`
- **Dependencies**: TASK-007 through TASK-010
- **Success criteria**: Final gate requires spec, plan, checklist, PASS Analysis Report, checked checklist, changelog, verify log, gate history, and PASS/DONE final status.

## Analysis Report

### Consistency Check

- [x] Every requirement in `spec.md` has a corresponding task in `plan.md`.
- [x] Every task in `plan.md` has a corresponding item in `checklist.md`.
- [x] Every verification command in `checklist.md` points to repository files or gate scripts.
- [x] Terminology uses the same phase names across spec, plan, and checklist.
- [x] REQ-001 through REQ-008 remain covered by TASK-001 through TASK-006.
- [x] REQ-009 through REQ-013 are covered by TASK-007 through TASK-011.
- [x] Checklist includes concrete verification commands for each new task.

### Conclusion

PASS. No CRITICAL issues. Implement may proceed only through the Phase 5 before-implement gate.

## Risk Control

- Keep shell scripts dependency-free and fail closed.
- Prefer readable checks over complex state machines.
- Preserve backward-compatible numeric phases in `check-phase-prereqs.sh` while adding named phase aliases where useful.
