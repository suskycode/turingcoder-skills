# TuringCoder Skills Integration Requirements

## 1. 背景与目标

为 TuringCoder 提供一个可安装的“集成能力 skill”。开发者安装该 skill 后，在聊天中说“帮我集成下skills能力”等语义请求时，能够自动完成 skills 基础集成。

## 2. 命令分工（关键约束）

- 安装“集成能力 skill”：
  - `openskills install <skill-url>`
- 安装 `find-skills` 发现的其他技能：
  - `npx skills add <package>`
- 预装基础技能：
  - `npx skills add <package> --agent Antigravity`

## 3. 标准目录与文件

- 规则目录：`.turing_coder_rules`
- 工作流目录：`.turing_coder_rules/workflows`
- skills 目录：`.agent/skill`
- root 规则文件：`AGENTS.md`
- 规则目录下软链接：`.turing_coder_rules/AGENTS.md -> ../AGENTS.md`

## 4. 自动集成流程

1. 安装 skill 后，一键部署 workflow 到项目
   - `bash ./.agent/skill/turingcoder-skills-integration/scripts/deploy-workflow.sh`
   - 在项目内生成：`.turing_coder_rules/workflows/integrate-skills.md`
   - 若目标已存在，先备份为 `.bak`，再覆盖。
2. 在聊天中触发
   - 输入：`帮我集成下skills能力`
3. 前置检查
   - 需有 `npx` 命令。
   - 若 `AGENTS.md` 已存在，立即中止（禁止覆盖）。
4. 创建目录
   - `.turing_coder_rules`
   - `.turing_coder_rules/workflows`
   - `.agent/skill`
5. 创建 root `AGENTS.md`
   - 写入统一 `<usage>` 模板。
   - 模板中的 skills 路径必须是 `./.agent/skill/<skill-name>/`。
6. 创建软链接
   - `.turing_coder_rules/AGENTS.md -> ../AGENTS.md`
   - 若失败，立即中止，不降级复制。
7. 预装技能
   - `find-skills`
   - `skill-creator`
   - 命令统一使用：`npx skills add ... --agent Antigravity`

## 5. 同步步骤（必须提示，非阻塞）

预装完成后必须提示用户执行：
- `npx openskills sync` 或
- `openskills sync`（全局安装场景）

说明：
- `sync` 需要用户在交互中选择同步项，无法纯命令行全自动完成。
- 集成流程在给出提示后可结束（非阻塞），但应明确“尚需用户完成 sync”。

## 6. 失败策略

- root `AGENTS.md` 已存在：失败并退出。
- `.turing_coder_rules/AGENTS.md` 已存在：失败并退出。
- 软链接创建失败：失败并退出。
- `npx skills add` 任一步失败：失败并退出，返回失败步骤。

## 7. 验收标准

1. 空项目执行后存在：
   - `AGENTS.md`
   - `.turing_coder_rules/AGENTS.md`（软链接）
   - `.agent/skill/`
2. 已有 `AGENTS.md` 时流程不覆盖文件。
3. 成功路径下会显示 `sync` 提示和人工交互说明。
4. 命令分工符合“第 2 节”，不混用 `openskills install` 与 `npx skills add`。
