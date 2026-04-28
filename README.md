# mini-speckit

`mini-speckit` 是一个极简、可复制的 Spec-Driven Development 基础模板。

它不复制官方 Spec Kit 的实现，只提取核心思想：先把约束、规格、计划、检查清单对齐，再让 AI Coding 工具进入实现阶段。

## 核心原则

- **先定义，再实现**：任何代码修改前，先明确项目约束、模块规格、实施计划和检查点。
- **不对齐，不写代码**：`spec.md`、`plan.md`、`checklist.md` 必须一致；不一致时只修正文档，不写代码。
- **文件即上下文**：关键决策沉淀到 `.mini-speckit/`，减少依赖聊天记录。
- **复制即可使用**：把 `.mini-speckit/` 和 `.github/copilot-instructions.md` 放入项目根目录，AI 工具即可读取同一套约束。

## 流程

1. 读取 `.mini-speckit/project-constraints.md`
2. 读取 `.mini-speckit/project-spec.md`
3. 选择模块并读取 `.mini-speckit/modules/<module>/complement.md`
4. 按模块流程执行：`Spec → Plan → Checklist → Align → Implement → Test`

## 初始化到其他项目

```bash
./scripts/init-mini-speckit.sh /absolute/path/to/target-project
```

脚本会复制：

- `.mini-speckit/`
- `.github/copilot-instructions.md`

## 目录结构

```text
mini-speckit/
  README.md
  .gitignore
  .mini-speckit/
    project-constraints.md
    project-spec.md
    modules/
      example-module/
        spec.md
        plan.md
        checklist.md
        complement.md
  .github/
    copilot-instructions.md
  scripts/
    init-mini-speckit.sh
```

## 与官方 Spec Kit 的关系

官方 Spec Kit 提供完整 CLI、模板、脚本和多 Agent 工作流。本项目只保留最小可迁移思想：把约束与流程固化为项目文件，让任意 AI Coding 执行器在写代码前先完成规格对齐。
