# Example Module Spec

## Pattern

The example module demonstrates how each business module should describe its spec, responsibilities, boundaries, and non-goals. After copying the template to an actual project, rename `example-module` to the real module name.

## Requirements

<!-- REQ-001: Describe the core requirement here -->
- Requirement 1: [describe what the module must do]

<!-- REQ-002: Describe input/output contract -->
- Requirement 2: [describe expected behavior]

<!-- REQ-003: Describe boundary constraint -->
- Requirement 3: [describe what the module must NOT do]

## Responsibilities

- Describe the core problem the module solves.
- Define module inputs, outputs, state, and error paths.
- List external interfaces or shared capabilities the module depends on.
- Constrain the APIs or interaction patterns the module exposes externally.

## Boundaries

- Module internal implementation is maintained only by this module.
- Cross-module calls must go through public interfaces or agreed-upon data structures.
- Shared logic must be lifted to a shared layer — no duplicate implementation across modules.
- Module tests should focus on critical functionality, boundary conditions, and failure paths.

## Non-Goals

- Does not take on data persistence responsibilities of other modules.
- Does not directly access other modules' internal files or private state.
- Does not introduce frameworks, services, or build tools unrelated to the current goal.
- Does not break project-level architecture constraints for temporary requirements.

## Notation

- `[NEW YYYY-MM-DD]` — newly added requirement
- `[CHANGED YYYY-MM-DD]` — modified requirement (old value deprecated)
- `~~old value~~ [DEPRECATED]` — replaced by newer requirement
