---
description: Phase 2 - 创建技术实现计划
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 前置检查

1. 检查 `.mini-spec-kit/modules/<模块名>/spec.md` 存在
2. 检查 spec.md 包含 `## Requirements` 章节
3. 如果前置检查失败，报错并提示先运行 `/specify <模块名>`

## 执行

1. 读取 `.mini-spec-kit/modules/<模块名>/spec.md`
2. 读取 `.mini-spec-kit/project-constraints.md` 了解架构约束
3. 生成或更新 `.mini-spec-kit/modules/<模块名>/plan.md`：
   - `## Task List`：每个任务关联 REQ-XXX ID
   - `## Change Type`：Bug Fix / Requirement Change / Enhancement / Refactoring
   - 每个任务包含：文件路径、依赖关系、成功标准
   - 不允许在此阶段修改代码

## 验证（自动）

```bash
./scripts/minispec-gate.sh --phase plan --module <模块名> --project-root .

# 检查 plan.md 存在
test -f .mini-spec-kit/modules/<模块名>/plan.md

# 检查包含 Task List 章节
grep -q "## Task List" .mini-spec-kit/modules/<模块名>/plan.md

# 检查每个任务有 REQ-XXX 引用（至少有 1 个）
grep -q "REQ-" .mini-spec-kit/modules/<模块名>/plan.md

./scripts/check-phase-prereqs.sh --phase 3 --module <模块名> --project-root .
```

如果验证失败，自动修复后重试，最多 3 次。

## 交接

输出完成摘要：
- 模块名
- plan 路径
- 任务数量
- 提示：下一步运行 `/checklist <模块名>`
