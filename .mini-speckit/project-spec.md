# Project Spec

## 项目目标

`mini-speckit` 提供一个可复制到任意项目的极简 AI Coding 规范骨架，使 Hermes、Codex 或其他执行器在写代码前先完成规格对齐，降低上下文漂移、越界修改和直接开写风险。

## 模块划分

- `project-constraints`：项目级入口，定义 AI 行为、禁止项、架构约束和 token 策略。
- `project-spec`：项目目标、模块关系、数据流和目录结构说明。
- `modules/<module>`：模块级规格、计划、检查清单和闭环流程。
- `copilot-instructions`：让 GitHub Copilot 等工具优先遵守 `.mini-speckit/` 约束。
- `init-script`：把模板复制到实际项目根目录。

## 数据流

```text
User Task
  ↓
Read project-constraints.md
  ↓
Read project-spec.md
  ↓
Select modules/<module>/complement.md
  ↓
Spec → Plan → Checklist
  ↓
Align documents only
  ↓
Implement code
  ↓
Test by checklist
  ↓
Report result and gaps
```

## 目录结构

```text
.mini-speckit/
  project-constraints.md
  project-spec.md
  modules/
    <module>/
      spec.md
      plan.md
      checklist.md
      complement.md
.github/
  copilot-instructions.md
scripts/
  init-mini-speckit.sh
```

## 使用边界

- 本项目不是官方 Spec Kit 的替代 CLI。
- 本项目不提供代码生成器、模板渲染器或 Agent 编排器。
- 本项目只定义最小规范文件和闭环执行规则。
