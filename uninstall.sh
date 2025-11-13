#!/bin/bash
# ---------------------------------------------------------------------------
# uninstall.sh
# Clean removal of all Realtek RTL8822CE fixes
# ---------------------------------------------------------------------------

set -e

echo "[+] Removing pacman hook and fix script..."
sudo rm -f /etc/pacman.d/hooks/90-rtl8822ce-fix.hook
sudo rm -f /usr/local/bin/fix-rtl8822ce.sh

echo "[+] Restoring default Realtek modules..."
sudo rm -f /etc/modprobe.d/blacklist-rtw88.conf /etc/modprobe.d/rtw88.conf
sudo modprobe -r rtw88_8822ce rtw88_pci rtw88_core || true
sudo modprobe rtw88_8822ce

echo "[✓] All custom fixes removed successfully."
