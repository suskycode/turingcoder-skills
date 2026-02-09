# integrate-skills

When user intent starts with `/integrate-skills.md` (recommended form: `/integrate-skills.md 集成下skill`), or is "帮我集成下skills", or equivalent:

1. Run:
```bash
__BOOTSTRAP_CMD__
```

2. If command fails:
- Report exact failed step and error message.
- Do not claim integration success.

3. If command succeeds:
- Report created/updated artifacts:
  - `AGENTS.md`
  - `.turing_coder_rules/AGENTS.md` symlink
  - `.agent/skills/`
- Report preinstalled skills:
  - `find-skills`
  - `skill-creator`
- Report mandatory manual next step (non-blocking):
  - `npx openskills sync`
  - `openskills sync`
- Explain that sync requires user interaction to choose targets and cannot be fully automated.

4. Command policy reminder:
- Use `npx openskills install https://github.com/suskycode/turingcoder-skills -u` only to install this integration skill.
- Use `npx skills add ... --agent antigravity` for skills discovered via `find-skills`.
- Prefer slash trigger for higher completion stability: `/integrate-skills.md 集成下skill`.
