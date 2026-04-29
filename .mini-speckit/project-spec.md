# Project Spec

## Project Goal

`mini-speckit` provides a minimal, copyable Spec-Driven Development base template for any project, enabling Hermes, Codex, or other executors to complete spec alignment before writing code — reducing context drift, scope creep, and premature implementation risks.

## Core Principles

- **Spec is the source of truth**: Code serves specs, not the other way around.
- **Artifact-driven flow**: Each phase produces artifacts that the next phase reads. No artifact → next phase cannot start.
- **No pre-checked checklists**: All checklist items start as `[ ]`. Implementation and verification are separate steps.
- **Change traceability**: Every change is recorded in `changelog.md` with requirement IDs.
- **Reconcile is mandatory**: After implementation, spec files must be updated to match the actual code.

## Module Breakdown

- `project-constraints`: Project-level entry point defining AI behavior, forbidden actions, architecture constraints, and token strategy.
- `project-spec`: Project goals, module relationships, data flow, and directory structure.
- `modules/<module>`: Module-level specs, plans, checklists, and closed-loop workflow.
- `copilot-instructions`: Makes GitHub Copilot and similar tools respect `.mini-speckit/` constraints first.
- `init-script`: Copies the template into the actual project root.

## Data Flow

```text
User Task
  ↓
Read project-constraints.md
  ↓
Read project-spec.md
  ↓
Select modules/<module>/complement.md
  ↓
Phase 1: Specify (update spec.md)
  ↓
Phase 2: Plan (update plan.md with Task List)
  ↓
Phase 3: Write Checklist (create checklist.md with verification commands)
  ↓
Phase 4: Analyze (consistency check, write Analysis Report)
  ↓
Phase 5: Implement (code changes only)
  ↓
Phase 6: Reconcile (verify checklist, update spec.md, write changelog)
  ↓
Done
```

## Directory Structure

```text
.mini-speckit/
  project-constraints.md
  project-spec.md
  modules/
    <module>/
      spec.md          # Current requirements state
      plan.md          # Implementation plan + Phase Status + Analysis Report
      checklist.md     # Verification items with requirement IDs and commands
      complement.md    # Module responsibilities and interfaces
      changelog.md     # Change history
.github/
  copilot-instructions.md
scripts/
  init-mini-speckit.sh
```

## Change Types

| Type | spec.md | changelog.md |
|------|---------|-------------|
| Bug Fix | No change (or add `## Known Issues`) | Record fix |
| Requirement Change | Mark `[CHANGED]` / `[DEPRECATED]` | Record change |
| Enhancement | Add `[NEW]` section | Record addition |
| Refactoring | No change (behavior preserved) | Record refactor |

## Usage Boundaries

- This project is not a replacement CLI for the official Spec Kit.
- This project does not provide code generators, template renderers, or agent orchestrators.
- This project only defines minimum spec files and closed-loop execution rules.
