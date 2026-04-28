# Example Module Plan

## 实现步骤

1. 读取 `project-constraints.md`、`project-spec.md` 和本模块 `complement.md`。
2. 根据用户任务更新或确认 `spec.md` 的职责、输入输出和边界。
3. 更新或确认本文件的实现步骤，确保每一步可验证、范围最小。
4. 更新或确认 `checklist.md` 的关键功能点、边界条件和失败路径。
5. 执行 Align：检查 `spec.md`、`plan.md`、`checklist.md` 是否一致。
6. Align 通过后，按计划进行最小代码修改。
7. 按 `checklist.md` 执行最小相关测试并记录结果。

## 风险控制

- 若计划需要触碰模块边界外文件，先回到 `spec.md` 明确原因。
- 若测试点无法执行，必须在最终报告中标记为环境、权限、服务或缺少依赖。
- 若发现需求冲突，只修改规范文档并请求确认，不进入实现。
