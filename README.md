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

Each phase produces artifacts that the next phase requires. **Skip a phase? The workflow stops.**

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
checklist.md has [ ] items? → Proceed to Analyze
Analysis Report passed? → Proceed to Implement
Build/test passes? → Proceed to Reconcile
All [x], spec matches code? → Done
```

## Quick Start

```bash
git clone https://github.com/zoomc/mini-spec-kit.git
cd mini-spec-kit
./scripts/init-mini-speckit.sh /path/to/your/project
```

This copies `.mini-spec-kit/` into your project. Your AI agent reads the constraints and follows the workflow.

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
