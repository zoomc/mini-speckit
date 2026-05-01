# Project: {{PROJECT_NAME}}

## AI Coding Rules

**All git-diff-producing changes MUST follow the mini-spec-kit 6-phase workflow.**

1. Read `.mini-spec-kit/project-constraints.md` first
2. Follow the workflow: Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
3. Phase gates are enforced by file checks — do NOT skip phases
4. Do NOT modify code before the Analyze phase passes

## Coding Principles

> Derived from Andrej Karpathy's LLM coding guidelines (100K+ stars). These apply during **every** Implement phase.

**1. Think Before Coding**
- State assumptions explicitly before writing code. If uncertain, stop and ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.

**2. Simplicity First**
- Write minimum code that solves the problem. Nothing speculative.
- No features beyond what was asked. No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

**3. Surgical Changes**
- Touch only what the plan specifies. Do not refactor adjacent code.
- Match existing style, even if you'd do it differently.
- When your changes create orphans (unused imports/vars), clean up only YOUR orphans.
- Test: Every changed line should trace directly to the user's request.

**4. Goal-Driven Execution**
- Transform tasks into verifiable goals before coding.
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- For multi-step tasks, state a brief plan with verify steps before implementing.

## Architecture

<!-- TODO: Fill in your project structure here -->

## Key Commands

<!-- TODO: Fill in build/test commands -->

## Code Standards

<!-- TODO: Fill in coding conventions -->

## Process Enforcement

**Any change that produces a git diff, including a one-line text edit, must satisfy all of these conditions:**

1. Run the complete mini-spec-kit flow: Specify → Plan → Checklist → Analyze → Implement → Reconcile.
2. Keep `checklist.md` unchecked before Implement; check items only during Reconcile.
3. Use `scripts/minispec-gate.sh` or `scripts/check-phase-prereqs.sh` to verify gates.

**Violating any condition makes the task invalid and requires returning to the missing phase.**

| 跳过行为 | 结果 |
|----------|------|
| 跳过 Specify/Plan 直接 Implement | ❌ 拒绝，输出作废 |
| 没有 Reconcile 就交付 | ❌ 拒绝，输出作废 |
| 以"改动太小"为由简化流程 | ❌ 拒绝，输出作废 |

**没有例外。没有"太小不用走流程"这回事。**

---

## Workflow

This project uses the mini-spec-kit 6-phase workflow. Always execute phases in order:

```text
Specify → Plan → Checklist → Analyze → Implement → Reconcile
```

| Phase | Command | Purpose |
|-------|---------|---------|
| 1 | `/specify <module>: <description>` | Create module specification |
| 2 | `/plan <module>` | Create technical implementation plan |
| 3 | `/checklist <module>` | Create verification checklist |
| 4 | `/analyze <module>` | Validate spec-plan alignment |
| 5 | `/implement <module>` | Write code per plan |
| 6 | `/reconcile <module>` | Verify and close checklist |

**Rules**:
- Each phase has gate checks — you cannot skip phases
- Do NOT modify code before Analyze passes
- Analyze checks spec/plan/checklist consistency only; Implement Permission is checked at Phase 5
- Before Implement, checklist items must be `[ ]` and must not contain `[x]`
- During Reconcile, passed items become `[x]`
- Run `scripts/minispec-gate.sh --phase <phase> --module <name> --project-root .` for hard gates
- A module is complete only after `scripts/minispec-gate.sh --phase final --module <name> --project-root .` exits 0
- Run `scripts/check-phase-prereqs.sh --phase N --module <name> --project-root .` for compatibility checks
