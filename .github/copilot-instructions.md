# Copilot Instructions

This project uses `.mini-spec-kit/` for spec-driven development. Before modifying code:

1. Read `.mini-spec-kit/project-constraints.md`
2. Read `.mini-spec-kit/project-spec.md`
3. Read the target module's files in `.mini-spec-kit/modules/<module>/`

## Workflow

Follow the 6-phase workflow for any change that produces a git diff:

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

## Rules

- **No alignment, no code**: `spec.md`, `plan.md`, `checklist.md` must be consistent before implementation.
- **No pre-checked checklists**: All checklist items start as `[ ]`.
- **Reconcile is mandatory**: After implementation, update spec files to match code and pass the final gate.
- **Requirement IDs**: Every requirement in `spec.md` must have a `<!-- REQ-XXX -->` marker.
- **Verification commands**: Every checklist item must have an exact command to run.
- **Hard gates**: Use `scripts/minispec-gate.sh` or `scripts/check-phase-prereqs.sh`; both inspect `.mini-spec-kit/modules/<module>`.
- **Completion**: A module is complete only when `scripts/minispec-gate.sh --phase final --module <module> --project-root .` exits 0.

## Phase Gates

| Gate | Check |
|------|-------|
| Specify → Plan | `spec.md` has `## Requirements` |
| Plan → Checklist | `plan.md` has `## Task List` |
| Checklist → Analyze | Checklist exists and has verification items |
| Analyze → Implement | `## Analysis Report` passed, checklist has `[ ]` and no `[x]`, and gate allows Implement |
| Implement → Reconcile | Build/test passes and git diff exists |
| Reconcile → Done | All `[x]`, spec matches code, logs updated, final gate passes |
