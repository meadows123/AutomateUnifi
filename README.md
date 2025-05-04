# AutomateUnifi

# 🔁 UniFi AP Controller Migration Automation

This project provides a simple and effective method to **automate the migration of UniFi Access Points (APs)** from an existing controller to a new one using SSH and the `set-inform` command.

This script was featured in the [CisConnects YouTube demo](https://www.youtube.com/channel/UCINSERTYOURCHANNELURL), where we walk through how to quickly move UniFi APs in a scalable, repeatable way — ideal for data center transitions, controller upgrades, or multi-site environments.

---

## ⚙️ What It Does

- Connects to one or more UniFi APs via SSH  
- Issues the `set-inform` command to point the APs to a new controller  
- Enables **batch adoption** of multiple devices without needing to manually reset or reconfigure each AP  
- Works for **Layer 3 adoption** where devices are not on the same subnet

---

## 📋 Prerequisites

- SSH access to UniFi APs (default user: `ubnt`, password: `ubnt` or as configured)  
- IP addresses of APs (from DHCP table, existing controller, or scan)  
- New UniFi controller's IP address or hostname (reachable on port `8080`)

---

## 📥 Usage

### 1. Edit the Script
Replace the placeholder variables in the script with your own values:

```bash
#!/bin/bash

AP_LIST=("10.0.0.11" "10.0.0.12" "10.0.0.13")
USER="ubnt"
PASS="yourpassword"
NEW_CONTROLLER="http://10.0.0.5:8080/inform"

for AP in "${AP_LIST[@]}"; do
    echo "Migrating $AP to new controller..."
    sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $USER@$AP "mca-cli-op set-inform $NEW_CONTROLLER"
done
