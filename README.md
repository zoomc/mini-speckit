# mini-spec-kit

[🇺🇸 English](README.md) | [🇨🇳 中文](README.zh-CN.md)

**Spec-driven development for AI coding agents — lightweight, traceable, token-efficient.**

`mini-spec-kit` is a minimal Spec-Driven Development framework designed for individual developers and small teams using AI coding agents. It enforces a structured 6-phase workflow that ensures stability, traceability, and quality — without the overhead of enterprise-grade tooling.

## Why mini-spec-kit?

AI coding agents are powerful, but they need guidance. Without a structured process, agents tend to:

- Write code before understanding requirements
- Introduce bugs that require expensive rework
- Lose context across sessions
- Generate undocumented, hard-to-maintain code

**mini-spec-kit solves this** with a lightweight, enforceable workflow that:

| Benefit | How |
|---------|-----|
| **Stability** | Requirements are frozen before code is written |
| **Traceability** | Every change links back to requirement IDs |
| **Token efficiency** | Minimal context injection — only what's needed |
| **Portability** | Works with any AI agent (Claude, GPT, Copilot, Cursor) |
| **Simplicity** | 6 phases, clear gates, no complex setup |

## How It Works

```
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

Each phase produces artifacts that the next phase requires. **Any git-diff-producing task must run all six phases.** Tiny tasks can keep artifacts short, but they do not skip the workflow.

| Phase | What Happens | Output |
|-------|--------------|--------|
| **Specify** | Define requirements with traceable IDs | `spec.md` |
| **Plan** | Break down into tasks with dependencies | `plan.md` |
| **Checklist** | Create verification commands | `checklist.md` |
| **Analyze** | Read-only consistency check | Analysis report |
| **Implement** | Write code according to plan | Working code |
| **Reconcile** | Verify and update specs | Updated docs |

## Anti-Skip Gates

Physical file checks prevent phase skipping:

```
spec.md has ## Requirements? → Proceed to Plan
plan.md has ## Task List? → Proceed to Checklist
checklist.md exists and has verification items? → Proceed to Analyze
Analysis Report passed, checklist has [ ] and no [x], gate allows Implement? → Proceed to Implement
Build/test passes and git diff exists? → Proceed to Reconcile
All [x], spec matches code, logs updated, final gate passes? → Done
```

Use the hard gate script when available:

```bash
./scripts/minispec-gate.sh --phase before-implement --module <module> --project-root .
./scripts/minispec-gate.sh --phase final --module <module> --project-root .
```

**Complete means the final gate passes.** A module is not complete merely because `spec.md`, `plan.md`, and `checklist.md` exist; it is complete only after Reconcile verifies the checklist, updates logs/changelog, and this command exits 0:

```bash
./scripts/minispec-gate.sh --phase final --module <module> --project-root .
```

The compatibility checker remains available:

```bash
./scripts/check-phase-prereqs.sh --phase 5 --module <module> --project-root .
```

Both scripts inspect `.mini-spec-kit/modules/<module>`.

## Gate Files

`gate.md` records workflow status and implementation permission. It is separate from `checklist.md`, which remains the business verification checklist. `verify.log` records verification command results, and `gate-history.log` records lightweight gate transitions.

## Quick Start

```bash
git clone https://github.com/zoomc/mini-spec-kit.git
cd mini-spec-kit
./scripts/init-mini-speckit.sh /path/to/your/project
```

This copies `.mini-spec-kit/`, `.github/copilot-instructions.md`, `.claude/commands/`, `.agents/skills/`, `AGENTS.md`, `CLAUDE.md`, and the gate scripts in `scripts/` into your project. Your AI agent reads the constraints and follows the workflow.

The bundled `example-module` is a pre-implementation open example. It demonstrates artifact shape and intentionally does not pass the final gate.

## Who Is This For?

- **Solo developers** using AI agents — prevent scope creep and rework
- **Small teams** — create documentation trails without overhead
- **AI agents** — structured workflow to follow

## vs. Official Spec Kit

| | mini-spec-kit | Official Spec Kit |
|-|---------------|-------------------|
| **Setup** | Copy one folder | Full CLI + templates |
| **Learning curve** | 5 minutes | Hours |
| **Token overhead** | Minimal | Higher |
| **Best for** | Individuals, small teams | Enterprise, large teams |

## License

MIT
