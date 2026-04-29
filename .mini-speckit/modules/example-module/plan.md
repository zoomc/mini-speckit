# Example Module Plan

## Phase Status

> Update this section at each phase transition. Next phase cannot start until previous phase is `[x]`.

- [ ] Specify: `spec.md` has `## Requirements` with requirement IDs
- [ ] Plan: `plan.md` has `## Task List` with file paths and dependencies
- [ ] Write Checklist: `checklist.md` generated with `[ ]` items and `**Verification**:` blocks
- [ ] Analyze: `plan.md` has `## Analysis Report` with consistency check
- [ ] Implement: Build/test passes
- [ ] Reconcile: All checklist items `[x]`, `spec.md` matches code, `changelog.md` updated

## Change Type

<!-- Fill in before starting. One of: Bug Fix / Requirement Change / Enhancement / Refactoring -->

- **Type**: [Bug Fix / Requirement Change / Enhancement / Refactoring]
- **Reason**: [why this change is needed]
- **Impact**: [which files will be affected]

## Task List

<!-- Each task must have: Requirement ID, files, dependencies, success criteria -->

### TASK-001: [Task Name]
- **Requirement**: REQ-001
- **Files**: `path/to/file.go`
- **Dependencies**: none
- **Success criteria**: [exact test command or verification]

### TASK-002: [Task Name]
- **Requirement**: REQ-002
- **Files**: `path/to/file.go`
- **Dependencies**: TASK-001
- **Success criteria**: [exact test command or verification]

## Implementation Steps

1. Read `project-constraints.md`, `project-spec.md`, and this module's `complement.md`.
2. Based on the user task, update or confirm `spec.md` requirements with requirement IDs.
3. Update or confirm this file's task list, ensuring each task has requirement ID, files, dependencies, and success criteria.
4. Update or confirm `checklist.md` with verification items and commands.
5. Run Analyze: check whether `spec.md`, `plan.md`, `checklist.md` are consistent. Write `## Analysis Report`.
6. After Analyze passes, proceed with minimal code changes per the plan.
7. Run verification per `checklist.md` and record results.

## Analysis Report

<!-- Write this during Phase 4: Analyze. Must check consistency between spec/plan/checklist. -->

### Consistency Check
- [ ] Every requirement in `spec.md` has a corresponding task in `plan.md`
- [ ] Every task in `plan.md` has a corresponding item in `checklist.md`
- [ ] Every verification command in `checklist.md` points to correct files/functions
- [ ] No terminology drift (spec and plan use the same terms)
- [ ] No coverage gaps (requirements without tasks / tasks without requirements)

### Conclusion
<!-- Pass / Needs fix: [describe issue] -->

## Risk Control

- If the plan needs to touch files outside the module boundary, go back to `spec.md` and clarify why first.
- If a test point cannot be executed, it must be marked in the final report as environment, permission, service, or missing dependency.
- If requirement conflicts are found, only modify spec docs and request confirmation — do not enter implementation.
