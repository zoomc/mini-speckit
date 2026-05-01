---
name: speckit-implement
description: Implement code changes according to a mini-spec-kit plan
version: 0.1.0
---

# speckit-implement

## 触发条件
用户要求实现代码时使用。

## 执行流程

### 前置检查
1. 检查 checklist.md 存在
2. 检查 plan.md 包含 `## Analysis Report` 且无 CRITICAL
3. 如果失败，提示先运行 `@speckit-analyze`

### 执行
1. 读取 plan.md 的 Task List
2. 按 Task List 顺序执行代码修改
3. 每完成一个任务，运行对应的 build/test 验证

### 验证
```bash
# 运行项目构建命令
# 检查修改的文件在 plan.md 的 Task List 中
```

### 交接
输出完成摘要，提示下一步运行 `@speckit-reconcile`
