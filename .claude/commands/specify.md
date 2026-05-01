---
description: Phase 1 - 创建模块规格说明
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>: <需求描述>`，例如 `news-page: 修复新闻标题英文未翻译问题`

## 前置检查

1. 读取 `.mini-spec-kit/project-constraints.md`（必须存在，不存在则报错停止）
2. 解析用户输入，提取模块名和需求描述
3. 如果模块目录 `.mini-spec-kit/modules/<模块名>/` 不存在，创建它

## 执行

1. 读取 `.mini-spec-kit/project-constraints.md` 了解项目约束
2. 读取 `templates/spec-template.md` 了解 spec 结构
3. 如果模块下已有 `spec.md`，读取并在现有基础上更新
4. 生成或更新 `.mini-spec-kit/modules/<模块名>/spec.md`：
   - 为每个需求分配 REQ-XXX ID（从 REQ-001 开始递增）
   - 新需求标记 `[NEW]`，修改的需求标记 `[CHANGED]`
   - 确保包含 `## Requirements` 章节
   - 每个需求必须是可测试的

## 验证（自动）

```bash
./scripts/minispec-gate.sh --phase specify --module <模块名> --project-root .

# 检查 spec.md 存在
test -f .mini-spec-kit/modules/<模块名>/spec.md

# 检查包含 Requirements 章节
grep -q "## Requirements" .mini-spec-kit/modules/<模块名>/spec.md

# 检查至少有 1 个 REQ-XXX
grep -q "REQ-" .mini-spec-kit/modules/<模块名>/spec.md

./scripts/check-phase-prereqs.sh --phase 2 --module <模块名> --project-root .
```

如果验证失败，自动修复后重试，最多 3 次。

## 交接

输出完成摘要：
- 模块名
- spec 路径
- 需求数量（REQ-XXX 数量）
- 提示：下一步运行 `/plan <模块名>`
