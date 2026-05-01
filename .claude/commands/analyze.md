---
description: Phase 4 - 一致性检查（只读）
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 前置检查

1. 检查 `.mini-spec-kit/modules/<模块名>/spec.md` 存在
2. 检查 `.mini-spec-kit/modules/<模块名>/plan.md` 存在
3. 检查 `.mini-spec-kit/modules/<模块名>/checklist.md` 存在
4. 如果任何文件缺失，报错并提示先运行前序命令

## 执行（不修改代码；只更新分析报告）

1. 读取三份文件
2. 检查一致性：
   - 每个 REQ-XXX 在 spec.md 中有定义
   - 每个 REQ-XXX 在 plan.md 的 Task List 中有对应任务
   - 每个任务在 checklist.md 中有对应的验证项
   - 无术语漂移（同一概念在三份文件中名称一致）
3. 在 plan.md 末尾追加 `## Analysis Report` 章节：
   - 需求覆盖情况
   - 任务覆盖情况
   - 发现的问题（如果有）
   - 结论：PASS 或 FAIL（附 CRITICAL 问题列表）

## 验证（自动）

```bash
./scripts/minispec-gate.sh --phase analyze --module <模块名> --project-root .

# 检查 plan.md 包含 Analysis Report
grep -q "## Analysis Report" .mini-spec-kit/modules/<模块名>/plan.md

# 检查报告中无 CRITICAL 问题
! grep -qi "CRITICAL" .mini-spec-kit/modules/<模块名>/plan.md

./scripts/check-phase-prereqs.sh --phase 4 --module <模块名> --project-root .
```

如果验证失败（有 CRITICAL 问题），必须先修复 spec/plan/checklist 中的问题，然后重新运行 analyze，最多 3 次。

## 交接

输出完成摘要：
- 模块名
- 分析结论（PASS/FAIL）
- 发现的问题数量
- 如果 PASS：提示下一步运行 `/implement <模块名>`
- 如果 FAIL：列出 CRITICAL 问题，提示修复后重新运行 `/analyze`
