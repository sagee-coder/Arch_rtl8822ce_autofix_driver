#!/bin/bash
# ---------------------------------------------------------------------------
# setup.sh
# One-command installer for RTL8822CE DKMS auto-repair system
# ---------------------------------------------------------------------------

set -e

echo "[+] Installing dependencies..."
sudo pacman -S --needed --noconfirm git dkms linux-headers base-devel
if ! command -v yay >/dev/null; then
  echo "[+] Installing yay (AUR helper)..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

echo "[+] Installing Realtek DKMS driver..."
yay -S --noconfirm rtw88-dkms-git

echo "[+] Deploying fix script and pacman hook..."
sudo install -Dm755 fix-rtl8822ce.sh /usr/local/bin/fix-rtl8822ce.sh
sudo install -Dm644 pacman-hooks/90-rtl8822ce-fix.hook /etc/pacman.d/hooks/90-rtl8822ce-fix.hook

echo "[+] Running initial fix..."
sudo /usr/local/bin/fix-rtl8822ce.sh

echo "[✓] Setup complete. Please reboot to activate Wi-Fi."
