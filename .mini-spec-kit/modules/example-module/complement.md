# Example Module Complement

## Closed-Loop Workflow

This module must follow:

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

## Specify

- Read existing `spec.md` to understand current state.
- For new features: add requirement sections with `<!-- REQ-XXX -->` markers.
- For changes: mark old requirements `[DEPRECATED]`, add new sections with `[NEW]` or `[CHANGED]`.
- For bug fixes: no spec change needed (or add `## Known Issues`).
- **Exit criteria**: `spec.md` has `## Requirements` section with requirement IDs.

## Plan

- Read `spec.md` requirements to understand what needs to change.
- Fill in `## Change Type` in `plan.md`.
- Write `## Task List` with: requirement ID, files, dependencies, success criteria.
- Each task must have a clear success criterion (exact test command or verification).
- **Exit criteria**: `plan.md` has `## Task List` with all tasks linked to requirement IDs.

## Write Checklist

- Read `plan.md` task list to understand what to verify.
- Create checklist items grouped by requirement ID.
- Each requirement section has:
  - **Implementation** items: what code artifacts must exist
  - **Verification** items: exact commands to run
  - **Regression** items: existing tests that must still pass
- All items start as `[ ]` — never pre-check.
- **Exit criteria**: `checklist.md` has at least one `[ ]` item, no `[x]` items, and all have `**Verification**:` blocks.

## Analyze

- Read `spec.md`, `plan.md`, `checklist.md` — do NOT modify any files.
- Check consistency:
  - Every requirement has a task
  - Every task has a checklist item
  - Every verification command points to correct files
  - No terminology drift
  - No coverage gaps
- Write `## Analysis Report` in `plan.md` with check results.
- If CRITICAL issues found: stop, fix spec/plan/checklist, re-analyze.
- **Exit criteria**: `plan.md` has `## Analysis Report` with no CRITICAL issues.

## Implement

- Read `plan.md` task list and `checklist.md` verification items.
- Make code changes strictly per the plan.
- Do NOT modify spec/plan/checklist files during implementation.
- If new conflicts discovered, stop and return to Analyze.
- Run build/test to verify code compiles and passes.
- Do not check off `checklist.md` items during Implement.
- **Exit criteria**: Build/test passes.

## Reconcile

- Run each verification command from `checklist.md`.
- Check off completed items with `[x]` and record verification date.
- Record verification output in `verify.log` and gate transitions in `gate-history.log` when those files exist.
- Re-read `spec.md`:
  - Remove `## Known Issues` if bug fix is complete
  - Verify `[NEW]`/`[CHANGED]` requirements are implemented
- Re-read `plan.md`:
  - Remove `## Current Task` section if present
- Update `changelog.md` with change description.
- Update `gate.md` final status when present.
- **Exit criteria**: All checklist items `[x]`, `spec.md` matches code, `changelog.md` and logs updated.

## Core Principle

**No alignment, no code. No reconcile, no done.**
