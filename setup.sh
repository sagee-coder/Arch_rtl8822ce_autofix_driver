#!/bin/bash
# ---------------------------------------------------------------------------
# fix-rtl8822ce.sh
# Realtek RTL8822CE DKMS auto-repair + reload script for Arch-based systems
# ---------------------------------------------------------------------------

set -e

echo "[+] Checking for RTL8822CE DKMS module..."
if dkms status | grep -q rtw88; then
  echo "[+] DKMS module found, rebuilding..."
  sudo dkms autoinstall
else
  echo "[!] DKMS module not found, installing..."
  yay -S --noconfirm rtw88-dkms-git
fi

echo "[+] Ensuring conflicting modules are blacklisted..."
sudo bash -c 'echo "blacklist rtw88_8822ce" > /etc/modprobe.d/blacklist-rtw88.conf'

echo "[+] Applying stability options..."
sudo bash -c 'cat > /etc/modprobe.d/rtw88.conf <<EOF
options rtw88_core disable_lps_deep=1
options rtw88_pci disable_aspm=1
EOF'

echo "[+] Reloading Wi-Fi driver..."
sudo modprobe -r rtw88_8822ce rtw88_pci rtw88_core || true
sudo modprobe rtw88_8822ce

echo "[✓] RTL8822CE Wi-Fi driver repaired and reloaded successfully."
