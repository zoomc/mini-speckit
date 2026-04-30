# speckit-plan

## 触发条件
用户要求创建技术实现计划时使用。

## 执行流程

### 前置检查
1. 检查 `.mini-spec-kit/modules/<模块名>/spec.md` 存在
2. 检查 spec.md 包含 `## Requirements` 章节
3. 如果失败，提示先运行 `@speckit-specify`

### 执行
1. 读取 `.mini-spec-kit/modules/<模块名>/spec.md`
2. 读取 `.mini-spec-kit/project-constraints.md` 了解架构约束
3. 生成或更新 `.mini-spec-kit/modules/<模块名>/plan.md`：
   - `## Task List`：每个任务关联 REQ-XXX ID
   - `## Change Type`：Bug Fix / Requirement Change / Enhancement / Refactoring
   - 每个任务包含：文件路径、依赖关系、成功标准

### 验证
```bash
test -f .mini-spec-kit/modules/<模块名>/plan.md
grep -q "## Task List" .mini-spec-kit/modules/<模块名>/plan.md
grep -q "REQ-" .mini-spec-kit/modules/<模块名>/plan.md
```

### 交接
输出完成摘要，提示下一步运行 `@speckit-checklist`
