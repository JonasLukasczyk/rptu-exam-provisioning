#!/usr/bin/env bash
set -euo pipefail

source ./config.sh

#
# ---------------------------------------------------------------------------
# PATHS
# ---------------------------------------------------------------------------
#

BUILD_DIR="$(realpath "$BUILD_DIR")"
PROXMOX_ISO_PATH="$(realpath "$PROXMOX_ISO_PATH")"

mkdir -p "$(dirname "$OUTPUT_ISO")"
OUTPUT_ISO="$(realpath -m "$OUTPUT_ISO")"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

GENERATED_SETUP_SCRIPT="$BUILD_DIR/exam-agent-setup.sh"


#
# ---------------------------------------------------------------------------
# GENERATE EXAM-AGENT SETUP SCRIPT
# ---------------------------------------------------------------------------
#

echo "Generating exam-agent setup script..."

export AGENT_REPO
export MANAGER_URL
export AGENT_PASSWORD
export PBS_HOST
export PBS_FINGERPRINT
export PVE_TOKEN_SECRET

envsubst \
    '$AGENT_REPO $MANAGER_URL $AGENT_PASSWORD $PBS_HOST $PBS_FINGERPRINT $PVE_TOKEN_SECRET' \
    < ./exam-agent-setup.sh.template \
    > "$GENERATED_SETUP_SCRIPT"

chmod 0755 "$GENERATED_SETUP_SCRIPT"

#
# ---------------------------------------------------------------------------
# PREPARE PROXMOX AUTOMATED INSTALL ISO
# ---------------------------------------------------------------------------
#

echo "Preparing Proxmox automated installer ISO..."
echo
echo "Answer endpoint:"
echo "  $ANSWER_URL"
echo

rm -f "$OUTPUT_ISO"

proxmox-auto-install-assistant prepare-iso \
    "$PROXMOX_ISO_PATH" \
    --fetch-from http \
    --url "$ANSWER_URL" \
    --on-first-boot "$GENERATED_SETUP_SCRIPT" \
    --output "$OUTPUT_ISO"
#
# ---------------------------------------------------------------------------
# DONE
# ---------------------------------------------------------------------------
#

echo
echo "========================================"
echo " ISO created successfully"
echo "========================================"
echo
echo "Output:"
echo "  $OUTPUT_ISO"
echo
