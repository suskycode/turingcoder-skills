# TuringCoder Skills Integration Requirements

## Scope

This skill bootstraps skills capability for a TuringCoder project.

## Normalized conventions

- Rules directory: `.turing_coder_rules`
- Skills directory: `.agent/skills`
- Agent selector for preinstall: `--agent Antigravity`
- Integration skill install command:
  - `npx openskills install https://github.com/suskycode/turingcoder-skills -u`

## Actions performed

1. Deploy project workflow with:
   - `bash ./.agent/skills/turingcoder-skills-integration/scripts/deploy-workflow.sh`
   - Template source: `references/workflows/integrate-skills.md` (bundled in this skill).
2. Trigger workflow in chat with "帮我集成下skills能力".
3. Bootstrap creates root `AGENTS.md`.
4. Bootstrap creates `.turing_coder_rules/AGENTS.md` as symlink to `../AGENTS.md`.
5. Bootstrap creates `.agent/skills`.
6. Bootstrap preinstalls:
   - `find-skills`
   - `skill-creator`
   using `npx skills add ... --agent Antigravity`.

## Hard failure rules

- If root `AGENTS.md` already exists, stop immediately.
- If `.turing_coder_rules/AGENTS.md` already exists, stop immediately.
- If symlink creation fails, stop immediately.
- Do not downgrade to file copy when symlink fails.

## Sync rule

After preinstall, always prompt user to run:
- `npx openskills sync` or
- `openskills sync`

This sync requires interactive manual selection and cannot be fully automated.

## Command split rule

- `npx openskills install https://github.com/suskycode/turingcoder-skills -u`:
  only for installing this integration skill package from this repo.
- `npx skills add ...`:
  for installing skills discovered from `find-skills`.
