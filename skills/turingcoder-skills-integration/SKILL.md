---
name: turingcoder-skills-integration
description: Integrate skills capability into a TuringCoder project by bootstrapping AGENTS.md, .turing_coder_rules symlink, .agent/skill layout, and preinstalling find-skills and skill-creator.
---

# TuringCoder Skills Integration

Use this skill when the user asks to integrate skills capability into a TuringCoder project, such as:
- "帮我集成下skills能力"
- "开启 skills 支持"
- "初始化 TuringCoder 的 skills 能力"

## Workflow

1. Deploy workflow into target project root:

```bash
bash ./.agent/skill/turingcoder-skills-integration/scripts/deploy-workflow.sh
```

2. In chat, ask:

```text
帮我集成下skills能力
```

3. The deployed workflow will run bootstrap:

```bash
bash ./.agent/skill/turingcoder-skills-integration/scripts/bootstrap.sh
```

4. If bootstrap succeeds, return:
- What was created
- Which skills were preinstalled
- The sync reminder (non-blocking):
  - `npx openskills sync`
  - `openskills sync`

5. Explain that sync requires user interaction to choose sync targets and cannot be fully automated by this skill.

## Important Constraints

- If `AGENTS.md` already exists in project root, bootstrap must stop and not overwrite it.
- Symlink creation `.turing_coder_rules/AGENTS.md -> ../AGENTS.md` is mandatory. If symlink fails, stop.
- Skills discovered via `find-skills` must be installed with `npx skills add ...`, not with `openskills install`.
- `openskills install` is for installing this integration skill itself.

## References

- Requirements and behavior details: `references/requirements.md`
