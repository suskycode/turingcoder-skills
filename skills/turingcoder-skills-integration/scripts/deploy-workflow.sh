#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="${1:-$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE="${SKILL_ROOT}/.turing_coder_rules/workflows/integrate-skills.md"
TARGET_DIR="${PROJECT_ROOT}/.turing_coder_rules/workflows"
TARGET_FILE="${TARGET_DIR}/integrate-skills.md"

if [[ ! -f "${TEMPLATE}" ]]; then
  echo "[ERROR] Workflow template not found: ${TEMPLATE}" >&2
  exit 1
fi

mkdir -p "${TARGET_DIR}"

if [[ "${SKILL_ROOT}" == "${PROJECT_ROOT}"/* ]]; then
  REL_SKILL_PATH="${SKILL_ROOT#${PROJECT_ROOT}/}"
  BOOTSTRAP_CMD="bash ./${REL_SKILL_PATH}/scripts/bootstrap.sh"
else
  BOOTSTRAP_CMD="bash ${SKILL_ROOT}/scripts/bootstrap.sh"
fi

if [[ -f "${TARGET_FILE}" ]]; then
  cp "${TARGET_FILE}" "${TARGET_FILE}.bak"
  echo "[INFO] Existing workflow backed up to ${TARGET_FILE}.bak"
fi

sed "s|__BOOTSTRAP_CMD__|${BOOTSTRAP_CMD}|g" "${TEMPLATE}" > "${TARGET_FILE}"

echo "[DONE] Workflow deployed: ${TARGET_FILE}"
echo "[INFO] Trigger it in chat with: 帮我集成下skills能力"
