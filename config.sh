#!/usr/bin/env bash

# Project
BUILD_DIR="./build"

# Proxmox ISO
PROXMOX_ISO_PATH="./iso/proxmox-ve_9.2-1.iso"

# Output
IMAGE_VERSION="0.1.0"
OUTPUT_ISO="./iso/proxmox-exam-${IMAGE_VERSION}.iso"

# Manager
MANAGER_URL='http://131.246.17.85:3000'
ANSWER_URL="${MANAGER_URL}/ProvisioningService.answer"

# exam-agent
AGENT_REPO='https://github.com/JonasLukasczyk/rptu-exam-agent'
AGENT_PASSWORD='aaaaaaaa'

# PBS
PBS_HOST="131.246.17.85"
PBS_FINGERPRINT=""
PVE_TOKEN_SECRET=""

