---
description: Phase 3 - 创建验证清单
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 前置检查

1. 检查 `.mini-spec-kit/modules/<模块名>/plan.md` 存在
2. 检查 plan.md 包含 `## Task List` 章节
3. 如果前置检查失败，报错并提示先运行 `/plan <模块名>`

## 执行

1. 读取 `.mini-spec-kit/modules/<模块名>/plan.md`
2. 生成或更新 `.mini-spec-kit/modules/<模块名>/checklist.md`：
   - 按 REQ-XXX 分组
   - 每项以 `- [ ]` 开头（全部未勾选）
   - 每项包含：
     - `### Implementation`：具体实现步骤
     - `### Verification`：验证命令（可执行的 shell 命令）
   - 不允许在此阶段修改代码

## 验证（自动）

```bash
./scripts/minispec-gate.sh --phase checklist --module <模块名> --project-root .

# 检查 checklist.md 存在
test -f .mini-spec-kit/modules/<模块名>/checklist.md

# 检查所有项都是 [ ]（无 [x]）
! grep -q "\[x\]" .mini-spec-kit/modules/<模块名>/checklist.md

# 检查每项有验证命令（grep Verification 块）
grep -q "### Verification" .mini-spec-kit/modules/<模块名>/checklist.md

./scripts/check-phase-prereqs.sh --phase 4 --module <模块名> --project-root .
```

如果验证失败，自动修复后重试，最多 3 次。

## 交接

输出完成摘要：
- 模块名
- checklist 路径
- 验证项数量
- 提示：下一步运行 `/analyze <模块名>`
