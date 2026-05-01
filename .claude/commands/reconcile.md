---
description: Phase 6 - 验证并关闭清单
---

## 用户输入

```text
$ARGUMENTS
```

格式：`<模块名>`，例如 `news-page`

## 前置检查

1. 检查 `.mini-spec-kit/modules/<模块名>/checklist.md` 存在
2. 检查代码是否已被修改（`git diff --quiet` 返回非零）
3. 如果代码未被修改，报错并提示先运行 `/implement <模块名>`

## 执行

1. 读取 `.mini-spec-kit/modules/<模块名>/checklist.md`
2. 运行每个 `- [ ]` 项的 `### Verification` 命令
3. 验证通过的项，将 `- [ ]` 改为 `- [x]`
4. 检查 spec.md 是否与实际代码一致，如有偏差则更新 spec.md
5. 更新 `.mini-spec-kit/modules/<模块名>/verify.log` 和 `gate-history.log`（如存在）
6. 更新 `.mini-spec-kit/modules/<模块名>/gate.md` 的 Final Result（如存在）
7. 创建或更新 `.mini-spec-kit/modules/<模块名>/changelog.md`：
   - 记录本次变更
   - 关联 REQ-XXX ID
   - 记录变更类型和影响

## 验证（自动）

```bash
# 检查所有 checklist 项都是 [x]
! grep -q "\[ \]" .mini-spec-kit/modules/<模块名>/checklist.md

# 检查 changelog.md 存在
test -f .mini-spec-kit/modules/<模块名>/changelog.md

./scripts/minispec-gate.sh --phase final --module <模块名> --project-root .
```

如果验证失败（有未通过的验证项），列出失败项并尝试修复，最多 3 次。

## 交接

输出完成摘要：
- 模块名
- 通过的验证项数量
- changelog 路径
- 提示：任务完成，所有阶段已关闭
