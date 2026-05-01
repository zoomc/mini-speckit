---
name: speckit-checklist
description: Create a verification checklist for a mini-spec-kit module
version: 0.1.0
---

# speckit-checklist

## 触发条件
用户要求创建验证清单时使用。

## 执行流程

### 前置检查
1. 检查 `.mini-spec-kit/modules/<模块名>/plan.md` 存在
2. 检查 plan.md 包含 `## Task List` 章节
3. 如果失败，提示先运行 `@speckit-plan`

### 执行
1. 读取 `.mini-spec-kit/modules/<模块名>/plan.md`
2. 生成或更新 `.mini-spec-kit/modules/<模块名>/checklist.md`：
   - 按 REQ-XXX 分组
   - 每项以 `- [ ]` 开头（全部未勾选）
   - 每项包含 `### Implementation` 和 `### Verification` 块

### 验证
```bash
test -f .mini-spec-kit/modules/<模块名>/checklist.md
! grep -q "\[x\]" .mini-spec-kit/modules/<模块名>/checklist.md
grep -q "### Verification" .mini-spec-kit/modules/<模块名>/checklist.md
```

### 交接
输出完成摘要，提示下一步运行 `@speckit-analyze`
