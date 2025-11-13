#!/bin/bash
set -e

echo "[+] Installing dependencies..."
sudo pacman -S --needed --noconfirm git dkms linux-headers base-devel
if ! command -v yay >/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

echo "[+] Installing Realtek driver..."
yay -S --noconfirm rtw88-dkms-git

echo "[+] Copying auto-fix script and hook..."
sudo install -Dm755 fix-rtl8822ce.sh /usr/local/bin/fix-rtl8822ce.sh
sudo install -Dm644 pacman-hooks/90-rtl8822ce-fix.hook /etc/pacman.d/hooks/90-rtl8822ce-fix.hook

echo "[+] Running first fix..."
sudo /usr/local/bin/fix-rtl8822ce.sh

echo "[✓] Done. Reboot to activate Wi-Fi."
