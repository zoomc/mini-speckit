# mini-speckit

`mini-speckit` is a minimal, copyable Spec-Driven Development base template.

It does not copy the official Spec Kit implementation — only the core idea: align constraints, specs, plans, and checklists before letting AI coding tools enter the implementation phase.

## Core Principles

- **Spec is the source of truth**: Code serves specs, not the other way around.
- **Artifact-driven flow**: Each phase produces artifacts that the next phase reads. No artifact → next phase cannot start.
- **No pre-checked checklists**: All checklist items start as `[ ]`. Implementation and verification are separate steps.
- **Change traceability**: Every change is recorded in `changelog.md` with requirement IDs.
- **Reconcile is mandatory**: After implementation, spec files must be updated to match the actual code.

## Workflow

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

| Phase | What | Output |
|-------|------|--------|
| **Specify** | Update `spec.md` with requirements | `spec.md` with requirement IDs |
| **Plan** | Write implementation plan + task list | `plan.md` with `## Task List` |
| **Write Checklist** | Create verification items with commands | `checklist.md` with `[ ]` items |
| **Analyze** | Consistency check (spec/plan/checklist) | `plan.md` with `## Analysis Report` |
| **Implement** | Code changes per plan | Code + build/test pass |
| **Reconcile** | Verify checklist + update spec | `checklist.md` `[x]` + `changelog.md` |

## Phase Gates

| Gate | Check | Fail Action |
|------|-------|-------------|
| Specify → Plan | `spec.md` has `## Requirements` | Stop, complete spec |
| Plan → Checklist | `plan.md` has `## Task List` | Stop, complete plan |
| Checklist → Analyze | No `[x]` in checklist, all have verification commands | Stop, fix checklist |
| Analyze → Implement | `## Analysis Report` with no CRITICAL issues | Stop, fix inconsistencies |
| Implement → Reconcile | Build/test passes | Stop, fix code |
| Reconcile → Done | All `[x]`, spec matches code | Stop, complete reconciliation |

## Initialize into Another Project

```bash
./scripts/init-mini-speckit.sh /absolute/path/to/target-project
```

The script copies:

- `.mini-speckit/`
- `.github/copilot-instructions.md`

## Directory Structure

```text
mini-speckit/
  README.md
  .gitignore
  .mini-speckit/
    project-constraints.md
    project-spec.md
    modules/
      example-module/
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

## Relationship with Official Spec Kit

The official Spec Kit provides a full CLI, templates, scripts, and multi-agent workflows. This project keeps only the minimum portable idea: freeze constraints and workflow into project files so any AI coding executor completes spec alignment before writing code.
