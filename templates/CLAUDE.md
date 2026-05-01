# Project: {{PROJECT_NAME}}

## AI Coding Rules

**All code changes MUST follow the mini-spec-kit 6-phase workflow.**

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

## ⛔ Process Enforcement (MANDATORY)

**任何代码修改（包括改一行文字）必须满足以下全部条件，否则直接拒绝执行：**

1. **双 session 模式**：CC1 (spec+reconcile) + CC2 (implement) 通过 file-marker 协调
2. **mini-spec-kit 全流程**：Specify → Plan → Checklist → Analyze → Implement → Reconcile
3. **Hermes 确认门禁**：需求确认 + 用户说 go 后才能 dispatch

**违反任一条件 = 任务失败，产出无效，必须重来。**

| 跳过行为 | 结果 |
|----------|------|
| 单 session 直接改代码 | ❌ 拒绝，输出作废 |
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
- All `[ ]` checklist items start unchecked — verify during Reconcile
- Run `scripts/check-phase-prereqs.sh --phase N --module <name> --project-root .` to check gates manually
