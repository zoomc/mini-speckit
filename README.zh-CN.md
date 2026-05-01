# mini-spec-kit

[🇺🇸 English](README.md) | [🇨🇳 中文](README.zh-CN.md)

**面向 AI 编码代理的规范驱动开发 —— 轻量、可溯源、省 token。**

`mini-spec-kit` 是一个极简的规范驱动开发框架，专为使用 AI 编码代理的个人开发者和小团队设计。它强制执行结构化的 6 阶段工作流，确保稳定性、可溯源性和质量——无需企业级工具的开销。

## 为什么选择 mini-spec-kit？

AI 编码代理很强大，但需要引导。没有结构化流程，代理往往会：

- 在理解需求之前就开始写代码
- 引入需要昂贵返工的 Bug
- 跨会话丢失上下文
- 生成无文档、难以维护的代码

**mini-spec-kit 解决了这个问题**，提供轻量级、可强制执行的工作流：

| 优势 | 如何实现 |
|------|----------|
| **稳定性** | 需求在写代码之前就已冻结 |
| **可溯源** | 每个变更都链接到需求 ID |
| **省 token** | 最小化上下文注入——只提供必要信息 |
| **可移植** | 适用于任何 AI 代理（Claude、GPT、Copilot、Cursor） |
| **简洁性** | 6 个阶段、清晰的门控、无需复杂设置 |

## 工作原理

```
规格说明 → 规划 → 写检查清单 → 分析 → 实现 → 对账
```

每个阶段产生下一个阶段所需的工件。**任何会产生 git diff 的任务都必须走完六个阶段。** Tiny task 可以保持文档很短，但不能跳过流程。

| 阶段 | 发生什么 | 输出 |
|------|----------|------|
| **规格说明** | 定义带可追溯 ID 的需求 | `spec.md` |
| **规划** | 分解为带依赖关系的任务 | `plan.md` |
| **检查清单** | 创建验证命令 | `checklist.md` |
| **分析** | 只读一致性检查 | 分析报告 |
| **实现** | 按计划编写代码 | 可运行的代码 |
| **对账** | 验证并更新规格 | 更新后的文档 |

## 防跳过门控

物理文件检查防止阶段跳过：

```
spec.md 有 ## 需求？ → 进入规划
plan.md 有 ## 任务列表？ → 进入检查清单
checklist.md 存在且有验证项？ → 进入分析
分析报告通过、checklist 有 [ ] 且没有 [x]、gate 允许实现？ → 进入实现
构建/测试通过且存在 git diff？ → 进入对账
全部 [x]，规格匹配代码，日志已更新，final 门禁通过？ → 完成
```

优先使用强门禁脚本：

```bash
./scripts/minispec-gate.sh --phase before-implement --module <模块名> --project-root .
./scripts/minispec-gate.sh --phase final --module <模块名> --project-root .
```

**完成意味着 final 门禁通过。** 模块不会因为 `spec.md`、`plan.md`、`checklist.md` 存在就算完成；只有 Reconcile 验证清单、更新日志和 changelog，并且下面命令退出 0，才算完成：

```bash
./scripts/minispec-gate.sh --phase final --module <模块名> --project-root .
```

兼容检查脚本仍可使用：

```bash
./scripts/check-phase-prereqs.sh --phase 5 --module <模块名> --project-root .
```

两个脚本都会检查 `.mini-spec-kit/modules/<模块名>`。

## Gate 文件

`gate.md` 记录流程状态和实现许可，和业务验证用的 `checklist.md` 分离。`verify.log` 记录验证命令结果，`gate-history.log` 记录轻量的门禁流转历史。

## 快速开始

```bash
git clone https://github.com/zoomc/mini-spec-kit.git
cd mini-spec-kit
./scripts/init-mini-speckit.sh /path/to/your/project
```

这会将 `.mini-spec-kit/`、`.github/copilot-instructions.md`、`.claude/commands/`、`.agents/skills/`、`AGENTS.md`、`CLAUDE.md` 和 `scripts/` 中的门禁脚本复制到你的项目中。你的 AI 代理读取约束并遵循工作流。

内置的 `example-module` 是预实现的开放示例，只用于展示工件形状，故意不通过 final 门禁。

## 谁适合使用？

- **独立开发者**使用 AI 代理——防止范围蔓延和返工
- **小团队**——无开销地创建文档轨迹
- **AI 代理**——结构化的工作流来遵循

## 对比官方 Spec Kit

| | mini-spec-kit | 官方 Spec Kit |
|-|---------------|---------------|
| **设置** | 复制一个文件夹 | 完整 CLI + 模板 |
| **学习曲线** | 5 分钟 | 数小时 |
| **Token 开销** | 最小 | 较高 |
| **最适合** | 个人、小团队 | 企业、大团队 |

## 许可证

MIT
