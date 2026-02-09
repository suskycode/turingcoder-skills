#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(pwd)"
ROOT_AGENTS="${ROOT_DIR}/AGENTS.md"
RULES_DIR="${ROOT_DIR}/.turing_coder_rules"
RULES_AGENTS_LINK="${RULES_DIR}/AGENTS.md"
WORKFLOW_DIR="${RULES_DIR}/workflows"
AGENT_SKILL_DIR="${ROOT_DIR}/.agent/skills"

# Fixed sources for reproducible installs.
FIND_SKILLS_PKG="${FIND_SKILLS_PKG:-openai/skills@find-skills}"
SKILL_CREATOR_PKG="${SKILL_CREATOR_PKG:-openai/skills@skill-creator}"

ensure_command() {
  local cmd="$1"
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "[ERROR] Missing required command: ${cmd}" >&2
    exit 1
  fi
}

write_agents_md() {
  cat > "${ROOT_AGENTS}" <<'EOF'
## Available Skills

<!-- SKILLS_TABLE_START -->
<usage>
When users ask you to perform tasks, check if any of the available skills below can help complete the task more effectively. Skills provide specialized capabilities and domain knowledge.

How to use skills:
- Invoke: Bash("openskills read <skill-name>") ; if the skill is not listed/installed, use find-skills to search & install.
- Skills are stored in this project at: `./.agent/skills/<skill-name>/`
  - Bundled resources live under: `references/`, `scripts/`, `assets/` inside the skill folder.
- IMPORTANT (path resolution):
  - When a skill requires running a bundled script or reading bundled files, ALWAYS set the working directory to the skill folder first:
    - Bash("cd ./.agent/skills/<skill-name> && python3 scripts/<script>.py ...")
    - Bash("cd ./.agent/skills/<skill-name> && bash scripts/<script>.sh ...")
  - Do NOT assume the process working directory is the project root; explicitly `cd` before using relative paths.
- If `openskills read` output includes a base directory, prefer that path; otherwise use `./.agent/skills/<skill-name>/` as the base directory.

Usage notes:
- Only use skills listed in <available_skills> below
- Do not invoke a skill that is already loaded in your context
- Each skill invocation is stateless
- Skills found by `find-skills` must be installed via `npx skills add ...`
</usage>
EOF
}

main() {
  ensure_command npx
  ensure_command ln

  if [[ -e "${ROOT_AGENTS}" ]]; then
    echo "[ERROR] ${ROOT_AGENTS} already exists. Policy requires stopping without overwrite." >&2
    exit 1
  fi

  mkdir -p "${RULES_DIR}" "${WORKFLOW_DIR}" "${AGENT_SKILL_DIR}"
  write_agents_md

  if [[ -e "${RULES_AGENTS_LINK}" || -L "${RULES_AGENTS_LINK}" ]]; then
    echo "[ERROR] ${RULES_AGENTS_LINK} already exists. Refusing to replace it." >&2
    exit 1
  fi

  ln -s ../AGENTS.md "${RULES_AGENTS_LINK}"

  echo "[INFO] Installing preloaded skills with Antigravity agent..."
  npx skills add "${FIND_SKILLS_PKG}" --agent Antigravity
  npx skills add "${SKILL_CREATOR_PKG}" --agent Antigravity

  cat <<'EOF'
[DONE] Base skills integration completed.

Next step (manual, required):
- npx openskills sync
  or
- openskills sync

Note:
- sync requires interactive user selection of what to sync.
- This step cannot be completed fully by automation.
EOF
}

main "$@"
