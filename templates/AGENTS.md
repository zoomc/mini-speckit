# Project: {{PROJECT_NAME}}

## AI Coding Rules

**All code changes MUST follow the mini-spec-kit 6-phase workflow.**

1. Read `.mini-spec-kit/project-constraints.md` first
2. Follow the workflow: Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
3. Phase gates are enforced by file checks — do NOT skip phases
4. Do NOT modify code before the Analyze phase passes

## Architecture

<!-- TODO: Fill in your project structure here -->

## Key Commands

<!-- TODO: Fill in build/test commands -->

## Code Standards

<!-- TODO: Fill in coding conventions -->

## Workflow

This project uses the mini-spec-kit 6-phase workflow. Always execute phases in order:

```text
Specify → Plan → Checklist → Analyze → Implement → Reconcile
```

| Phase | Skill | Purpose |
|-------|-------|---------|
| 1 | `@speckit-specify` | Create module specification |
| 2 | `@speckit-plan` | Create technical implementation plan |
| 3 | `@speckit-checklist` | Create verification checklist |
| 4 | `@speckit-analyze` | Validate spec-plan alignment |
| 5 | `@speckit-implement` | Write code per plan |
| 6 | `@speckit-reconcile` | Verify and close checklist |

**Rules**:
- Each phase has gate checks — you cannot skip phases
- Do NOT modify code before Analyze passes
- All `[ ]` checklist items start unchecked — verify during Reconcile
- Run `scripts/check-phase-prereqs.sh --phase N --module <name> --project-root .` to check gates manually
