# Copilot Instructions

This project uses `.mini-speckit/` for spec-driven development. Before modifying code:

1. Read `.mini-speckit/project-constraints.md`
2. Read `.mini-speckit/project-spec.md`
3. Read the target module's files in `.mini-speckit/modules/<module>/`

## Workflow

Follow the 6-phase workflow for any non-trivial change:

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

## Rules

- **No alignment, no code**: `spec.md`, `plan.md`, `checklist.md` must be consistent before implementation.
- **No pre-checked checklists**: All checklist items start as `[ ]`.
- **Reconcile is mandatory**: After implementation, update spec files to match code.
- **Requirement IDs**: Every requirement in `spec.md` must have a `<!-- REQ-XXX -->` marker.
- **Verification commands**: Every checklist item must have an exact command to run.

## Phase Gates

| Gate | Check |
|------|-------|
| Specify → Plan | `spec.md` has `## Requirements` |
| Plan → Checklist | `plan.md` has `## Task List` |
| Checklist → Analyze | No `[x]` in checklist |
| Analyze → Implement | `## Analysis Report` passed |
| Implement → Reconcile | Build/test passes |
| Reconcile → Done | All `[x]`, spec matches code |
