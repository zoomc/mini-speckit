# Code Gate Changelog

> Record completed changes during Reconcile.

## 2026-05-01: Hard Gate Enforcement

- **Type**: Enhancement
- **Changed**: Added `scripts/minispec-gate.sh` with eight phases (specify, plan, checklist, analyze, before-implement, after-implement, reconcile, final). Updated `scripts/check-phase-prereqs.sh` to use `.mini-spec-kit/modules/<module>` and enforce unchecked checklist before Implement. Added `gate.md`, `verify.log`, and `gate-history.log` conventions to example-module and code-gate modules. Reconciled agent docs (README, CLAUDE.md, AGENTS.md, .claude/commands, .agents/skills) to reference gate scripts and remove Hermes/dual-session conflicts.
- **Reason**: Hard gate enforcement was incomplete; agent instructions contained conflicting dual-session and Hermes-only requirements.
- **Files**: scripts/check-phase-prereqs.sh, scripts/minispec-gate.sh, scripts/init-mini-speckit.sh, .mini-spec-kit/modules/example-module/{gate.md,verify.log,gate-history.log,complement.md}, .mini-spec-kit/modules/code-gate/*, .mini-spec-kit/project-constraints.md, .mini-spec-kit/project-spec.md, .github/copilot-instructions.md, README.md, README.zh-CN.md, templates/CLAUDE.md, templates/AGENTS.md, .claude/commands/*.md, .agents/skills/*/SKILL.md, .gitignore
- **Requirement**: REQ-001, REQ-002, REQ-003, REQ-004, REQ-005, REQ-006, REQ-007

## 2026-05-01: Analyze/Implement Gate Refinement

- **Type**: Bug Fix
- **Changed**: Separated Analyze gate checks from Phase 5 Implement Permission checks. Analyze now accepts already reconciled modules with checked checklist items as long as checklist structure is valid. Before-implement still rejects any checked checklist item and still requires an unchecked item. Removed the Analyze command's before-implement validation.
- **Reason**: The previous hard gate layer could misclassify already reconciled modules as ordinary unimplemented modules during Analyze and could run Implement Permission checks too early.
- **Files**: scripts/minispec-gate.sh, scripts/check-phase-prereqs.sh, .claude/commands/analyze.md, README.md, README.zh-CN.md, templates/CLAUDE.md, templates/AGENTS.md, .mini-spec-kit/project-constraints.md, .mini-spec-kit/project-spec.md, .github/copilot-instructions.md, .mini-spec-kit/modules/code-gate/*
- **Requirement**: REQ-008

## 2026-05-01: Workflow Enforcement Optimization Partial

- **Type**: Enhancement
- **Changed**: Strengthened final gate validation to require spec, plan, PASS analysis report, checked checklist, changelog, verification log, gate history, and PASS/DONE final result. Updated init source checks and install summary. Clarified final-complete semantics in English/Chinese docs and templates. Marked example-module as a pre-implementation/open example that intentionally fails final validation.
- **Reason**: Mini Spec Kit should fail fast when phases are skipped and should not imply artifact existence equals completion.
- **Files**: scripts/minispec-gate.sh, scripts/init-mini-speckit.sh, README.md, README.zh-CN.md, templates/CLAUDE.md, templates/AGENTS.md, .github/copilot-instructions.md, .mini-spec-kit/project-constraints.md, .mini-spec-kit/project-spec.md, .mini-spec-kit/modules/example-module/*, .mini-spec-kit/modules/code-gate/*
- **Requirement**: REQ-010, REQ-011, REQ-012, REQ-013
- **Blocked**: REQ-009 still requires `.agents/skills/*/SKILL.md` edits, but this sandbox denied writes under `.agents/skills` with `Operation not permitted`.
