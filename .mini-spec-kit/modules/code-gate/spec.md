# Code Gate Spec

## Pattern

The code gate module defines hard workflow checks for mini-spec-kit itself and for projects initialized from this template.

## Requirements

<!-- REQ-001: All git-diff-producing work must follow six phases -->
- [NEW 2026-05-01] Any action that produces a git diff must follow the complete MiniSpec Kit workflow: Specify -> Plan -> Checklist -> Analyze -> Implement -> Reconcile. Tiny tasks may keep artifacts short but may not skip phases.

<!-- REQ-002: Phase prerequisite checks use the real module directory -->
- [NEW 2026-05-01] Phase prerequisite checks must inspect `.mini-spec-kit/modules/<module>` under the project root, not `modules/<module>`.

<!-- REQ-003: Checklist lifecycle is enforced -->
- [NEW 2026-05-01] Before Implement, `checklist.md` must exist, contain at least one unchecked `- [ ]` item, and contain no checked `- [x]` items. Checked items are only allowed or required during Reconcile and final closure.

<!-- REQ-004: A hard gate script exists -->
- [NEW 2026-05-01] `scripts/minispec-gate.sh` must exit 1 on gate failure and 0 on success. It must support `specify`, `plan`, `checklist`, `analyze`, `before-implement`, `after-implement`, `reconcile`, and `final`.

<!-- REQ-005: Gate state is separate from business checklist -->
- [NEW 2026-05-01] Modules may use `gate.md` for workflow state with sections: `Workflow Status`, `Gate Status`, `Implement Permission`, `Final Result`, `Blockers`, and `History`. This file must not replace or mix with `checklist.md`.

<!-- REQ-006: Lightweight logs are documented -->
- [NEW 2026-05-01] Modules may use `verify.log` and `gate-history.log` as lightweight text logs for verification results and gate transitions. The convention must stay file-based and not introduce services, databases, or deployment requirements.

<!-- REQ-007: Agent-facing docs and commands use gate checks -->
- [NEW 2026-05-01] README files, templates, Claude commands, and Codex skills must direct agents to use `scripts/minispec-gate.sh` or `scripts/check-phase-prereqs.sh` for phase gates and must not contain conflicting Hermes-only or dual-session requirements.

<!-- REQ-008: Analyze and Implement gates remain phase-specific and rerunnable -->
- [NEW 2026-05-01] Analyze gates must only require analysis inputs and checklist structure, so already reconciled modules can rerun analysis without being misclassified as unimplemented. Implement gates must remain stricter: before-implement must require at least one unchecked `- [ ]` checklist item and must reject any checked `- [x]` item.

<!-- REQ-009: Phase commands and skills fail fast through the hard gate -->
- [NEW 2026-05-01] Every phase command and skill must run or document the matching `scripts/minispec-gate.sh --phase <phase>` check before proceeding to the next phase. Implement must run `before-implement`; Reconcile must run `final`.

<!-- REQ-010: Final completion semantics are explicit -->
- [NEW 2026-05-01] README documentation must state that a module is complete only when the `final` gate passes, not merely when `spec.md`, `plan.md`, and `checklist.md` exist.

<!-- REQ-011: Initialized projects receive all workflow context -->
- [NEW 2026-05-01] `scripts/init-mini-speckit.sh` must install the required context files and executable gate scripts into target projects, including `.mini-spec-kit`, `.github/copilot-instructions.md`, `.claude/commands`, `.agents/skills`, `AGENTS.md`, `CLAUDE.md`, and `scripts/{check-phase-prereqs.sh,minispec-gate.sh}`.

<!-- REQ-012: Example module final status is not misleading -->
- [NEW 2026-05-01] The bundled `example-module` must clearly identify itself as a pre-implementation/open example and must not be presented as a final-complete module.

<!-- REQ-013: Final gate validates full closed-loop artifacts -->
- [NEW 2026-05-01] The `final` gate must validate the complete closed-loop state: spec, plan, checklist, PASS analysis report, checked checklist, changelog, verification log, gate history, and PASS/DONE final result.

## Boundaries

- Keep the six-phase model intact.
- Do not introduce services, databases, daemons, deployment workflows, or external dependencies.
- Keep scripts portable Bash.
