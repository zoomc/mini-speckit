---
name: speckit-specify
description: Create or update module specifications for mini-spec-kit
version: 0.1.0
---

# speckit-specify

## 触发条件
用户要求创建或更新模块规格说明时使用。

## 执行流程

### 前置检查
1. 读取 `.mini-spec-kit/project-constraints.md`（必须存在）
2. 解析用户输入，提取模块名和需求描述
3. 如果模块目录 `.mini-spec-kit/modules/<模块名>/` 不存在，创建它

### 执行
1. 读取 `.mini-spec-kit/project-constraints.md` 了解项目约束
2. 读取 `templates/spec-template.md` 了解 spec 结构
3. 如果模块下已有 `spec.md`，读取并在现有基础上更新
4. 生成或更新 `.mini-spec-kit/modules/<模块名>/spec.md`：
   - 为每个需求分配 REQ-XXX ID（从 REQ-001 开始递增）
   - 新需求标记 `[NEW]`，修改的需求标记 `[CHANGED]`
   - 确保包含 `## Requirements` 章节
   - 每个需求必须是可测试的

### 验证
```bash
test -f .mini-spec-kit/modules/<模块名>/spec.md
grep -q "## Requirements" .mini-spec-kit/modules/<模块名>/spec.md
grep -q "REQ-" .mini-spec-kit/modules/<模块名>/spec.md
```

### 交接
输出完成摘要，提示下一步运行 `@speckit-plan`
