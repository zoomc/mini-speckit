---
description: Phase 5 - 实现代码
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 前置检查

1. 检查 `.mini-spec-kit/modules/<模块名>/checklist.md` 存在
2. 检查 checklist 至少有一个 `- [ ]` 项，且没有任何 `- [x]` 项
3. 检查 `.mini-spec-kit/modules/<模块名>/plan.md` 存在且有 `## Analysis Report`
4. 如果 Analysis Report 包含 CRITICAL 问题，STOP 并提示先运行 `/analyze` 修复
5. 运行 `./scripts/minispec-gate.sh --phase before-implement --module <模块名> --project-root .`
6. 如果前置检查失败，报错并提示先运行前序命令

## 执行

1. 读取 `.mini-spec-kit/modules/<模块名>/plan.md` 的 Task List
2. 按 Task List 顺序执行代码修改
3. 每完成一个任务，运行对应的 build/test 验证
4. 不允许勾选 checklist（这些在 Reconcile 阶段处理）

## 验证（自动）

```bash
# 运行项目构建命令（根据项目类型自动检测）
# Go 项目：cd backend && go build ./...
# Node 项目：npm run build
# Python 项目：python -m pytest

# 检查修改的文件是否在 plan.md 的 Task List 中
# （通过 git diff 检查修改了哪些文件，与 plan.md 中的文件路径对比）

./scripts/minispec-gate.sh --phase after-implement --module <模块名> --project-root .
```

如果 build/test 失败，自动修复后重试，最多 3 次。

## 交接

输出完成摘要：
- 模块名
- 修改的文件列表
- build/test 结果
- 提示：下一步运行 `/reconcile <模块名>`
