#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ACTIONS_DIR="${HOME}/.local/share/nemo/actions"
ACTION_FILE="batch-convert-images@badmotorfinger.nemo_action"
HELPER_DIR="batch-convert-images"
SCRIPT_REL="${HELPER_DIR}/batch-convert-images.sh"

for dep in nemo jhead zenity; do
    command -v "$dep" >/dev/null 2>&1 || echo "WARNING: '$dep' is not installed; install it before using this action."
done

mkdir -p "${ACTIONS_DIR}/${HELPER_DIR}"

if [ "${SRC_DIR}" != "${ACTIONS_DIR}" ]; then
    install -m 0755 "${SRC_DIR}/${SCRIPT_REL}" "${ACTIONS_DIR}/${SCRIPT_REL}"
    install -m 0644 "${SRC_DIR}/${HELPER_DIR}/icon.png" "${ACTIONS_DIR}/${HELPER_DIR}/icon.png"
    install -m 0644 "${SRC_DIR}/${HELPER_DIR}/metadata.json" "${ACTIONS_DIR}/${HELPER_DIR}/metadata.json"
else
    chmod 0755 "${ACTIONS_DIR}/${SCRIPT_REL}"
fi

TMP="$(mktemp)"
sed "s|^Exec=.*|Exec=${ACTIONS_DIR}/${SCRIPT_REL} %F|" "${SRC_DIR}/${ACTION_FILE}" > "${TMP}"
mv "${TMP}" "${ACTIONS_DIR}/${ACTION_FILE}"

command -v nemo >/dev/null 2>&1 && nemo -q >/dev/null 2>&1 || true

echo "Installed the 'Remove JPEG metadata' action to ${ACTIONS_DIR}"
echo "Select one or more JPEG files in Nemo, right-click, and choose 'Remove JPEG metadata'."
