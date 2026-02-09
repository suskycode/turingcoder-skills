# TuringCoder Skills Integration

让 TuringCoder 项目快速具备 skills 能力。

## 超短版（10 秒看完）

```bash
# 1) 安装本 skill
npx openskills install https://github.com/suskycode/turingcoder-skills -u
# 2) 在项目根部署 workflow
bash ./.agent/skills/turingcoder-skills-integration/scripts/deploy-workflow.sh
# 3) 聊天里说：帮我集成下skills能力
# 4) 最后手动执行：npx openskills sync  （或 openskills sync）
```

## 快速开始

1. 安装本 skill

```bash
npx openskills install https://github.com/suskycode/turingcoder-skills -u
```

2. 在你的项目根目录部署 workflow

```bash
bash ./.agent/skills/turingcoder-skills-integration/scripts/deploy-workflow.sh
```

3. 在 TuringCoder 聊天中触发

```text
帮我集成下skills能力
```

## 完成后必须执行

```bash
npx openskills sync
# 或（全局安装时）
openskills sync
```

`sync` 需要你手动选择同步项，不能全自动完成。

## 命令分工

- 安装当前本 skill：`npx openskills install https://github.com/suskycode/turingcoder-skills -u`
- 通过 `find-skills` 找到的新 skill：`npx skills add <package>`

## 集成会做什么

- 创建项目根 `AGENTS.md`
- 创建 `.turing_coder_rules/AGENTS.md -> ../AGENTS.md` 软链接
- 创建 `.agent/skills/`
- 预装 `find-skills` 与 `skill-creator`
