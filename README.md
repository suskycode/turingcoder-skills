# turingcoder-skills

用于存放 TuringCoder 相关 skills 的仓库。

当前本仓库只有 1 个 skill：`turingcoder-skills-integration`。

## 安装当前本 skill

```bash
npx openskills install https://github.com/suskycode/turingcoder-skills -u
```

## 当前可用 skills

- `turingcoder-skills-integration`：为项目自动集成 skills 基础能力（创建 `AGENTS.md`、规则软链接、预装基础 skills）。

详细说明见：`skills/turingcoder-skills-integration/README.md`

## 快速使用（提炼版）

1. 在目标项目根目录部署 workflow：

```bash
bash ./.agent/skills/turingcoder-skills-integration/scripts/deploy-workflow.sh
```

2. 在聊天里触发：

```text
/integrate-skills.md 集成下skill
# 或（自然语言兜底）
帮我集成下skills
```

3. 完成后执行：

```bash
npx openskills sync
```

说明：通过 `find-skills` 发现的其他 skills，使用 `npx skills add <package>` 安装。
