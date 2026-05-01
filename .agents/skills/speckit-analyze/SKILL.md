---
name: speckit-analyze
description: Run consistency checks across spec, plan, and checklist
version: 0.1.0
---

# speckit-analyze

## 触发条件
用户要求进行一致性检查时使用。

## 执行流程

### 前置检查
1. 检查 spec.md、plan.md、checklist.md 都存在
2. 如果任何文件缺失，提示先运行前序命令

### 执行（只读）
1. 读取三份文件
2. 检查一致性：
   - 每个 REQ-XXX 在 spec.md 中有定义
   - 每个 REQ-XXX 在 plan.md 的 Task List 中有对应任务
   - 每个任务在 checklist.md 中有对应的验证项
3. 在 plan.md 末尾追加 `## Analysis Report`

### 验证
```bash
grep -q "## Analysis Report" .mini-spec-kit/modules/<模块名>/plan.md
! grep -qi "CRITICAL" .mini-spec-kit/modules/<模块名>/plan.md
```

### 交接
如果 PASS：提示下一步运行 `@speckit-implement`
如果 FAIL：列出问题，提示修复后重新运行 `@speckit-analyze`
