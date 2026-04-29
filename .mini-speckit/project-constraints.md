# Project Constraints

> **Single entry point**: Any AI coding executor must read this file first before modifying code, then read `project-spec.md` and the target module's files.

## AI Coding Behavior Rules

- Understand constraints, goals, and module boundaries before proposing or updating an implementation plan.
- Non-trivial changes must follow the target module's 6-phase workflow: `Specify → Plan → Write Checklist → Analyze → Implement → Reconcile`.
- All key requirements, trade-offs, boundaries, and verification points must be written to files — no reliance on chat context.
- Scope of changes must be minimized; only touch files relevant to the current task.
- When specs are unclear, plans conflict, or checkpoints are missing, fill in the docs first — do not jump to code.

## Forbidden Actions

- Do not skip `project-constraints.md` and modify code directly.
- Do not implement code when `spec.md`, `plan.md`, `checklist.md` are not aligned.
- Do not delete key constraints, weaken boundaries, or bypass requirements to pass tests.
- Do not expand task scope, rewrite unrelated modules, or refactor unrelated code opportunistically.
- Do not misclassify environment, permission, or external service issues as code bugs.
- Do not pre-check checklist items — all items start as `[ ]`.

## Architecture Constraints

- The project must maintain clear module boundaries: modules expose only necessary interfaces and do not cross-layer access internal implementations.
- Data flow must be traceable: input, processing, output, and error paths should be locatable in `project-spec.md` or module specs.
- Shared capabilities should be consolidated into shared modules; business modules must not copy-paste complex logic.
- Maintain backward compatibility by default; breaking changes must be explicitly stated in specs and plans.
- Test strategy should cover critical paths, boundary conditions, and failure paths — do not pursue irrelevant comprehensive validation.

## Token Optimization Strategy

- Read this file, `project-spec.md`, and target module files first, then read code on demand.
- Use file paths and symbol names to locate context; avoid full-repo scanning.
- Read small scopes first, then expand context; only search further when evidence is insufficient.
- Keep plans and reports in short sentences; avoid copying large blocks of source code or logs.
- Write reusable conclusions back to module docs to reduce future repeated explanations.

## Execution Thresholds

- Before Implement: only allowed to modify `spec.md`, `plan.md`, `checklist.md`, `complement.md`, `changelog.md` and other spec files.
- After Analyze passes: allowed to enter Implement, and must execute with minimal scope per `plan.md`.
- After Implement: must run verification per `checklist.md`, check off completed items, and update `changelog.md`.

## 6-Phase Workflow

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

### Phase Gates

| Gate | Check | Fail Action |
|------|-------|-------------|
| Specify → Plan | `spec.md` has `## Requirements` or `## Change Request` | Stop, complete spec first |
| Plan → Checklist | `plan.md` has `## Task List` | Stop, complete plan first |
| Checklist → Analyze | `checklist.md` has no `[x]` items, all have `**Verification**:` blocks | Stop, fix checklist |
| Analyze → Implement | `plan.md` has `## Analysis Report` with no CRITICAL issues | Stop, fix inconsistencies |
| Implement → Reconcile | Build/test passes | Stop, fix code |
| Reconcile → Done | All checklist items `[x]`, `spec.md` matches code | Stop, complete reconciliation |
