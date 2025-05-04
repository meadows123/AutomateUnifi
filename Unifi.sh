#!/bin/bash

# === CONFIGURATION ===
AP_USER="<USERNAME>"
AP_PASS="<PASSWORD>"
INFORM_URL="<NEW-CONTROLLER-IP>"

# List of AP IPs
AP_LIST=(
  "<IP-ADDRESS>"
)

# === SCRIPT START === (Main Loop)
for AP in "${AP_LIST[@]}"; do
  echo "👉 Connecting to $AP..."

  # Try to SSH into AP and set-inform once
  sshpass -p "$AP_PASS" ssh -o ConnectTimeout=10 \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o HostKeyAlgorithms=+ssh-rsa \
    -o PubkeyAcceptedKeyTypes=+ssh-rsa \
    "$AP_USER@$AP" "mca-cli-op set-inform $INFORM_URL"

  # Error Handling
  if [ $? -ne 0 ]; then
    echo "❌ Failed to connect or run set-inform on $AP. Check network, credentials, or SSH access."
    continue
  else
    echo "✅ set-inform sent successfully to $AP."
  fi

  echo "---------------------------------------------"
done
