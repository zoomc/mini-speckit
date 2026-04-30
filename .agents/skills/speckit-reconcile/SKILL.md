# speckit-reconcile

## 触发条件
用户要求验证并关闭清单时使用。

## 执行流程

### 前置检查
1. 检查 checklist.md 存在
2. 检查代码已被修改（git diff）
3. 如果失败，提示先运行 `@speckit-implement`

### 执行
1. 运行 checklist.md 中每个验证命令
2. 验证通过的项，将 `- [ ]` 改为 `- [x]`
3. 检查 spec.md 是否与实际代码一致
4. 创建或更新 changelog.md

### 验证
```bash
! grep -q "\[ \]" .mini-spec-kit/modules/<模块名>/checklist.md
test -f .mini-spec-kit/modules/<模块名>/changelog.md
```

### 交接
输出完成摘要，提示任务完成
