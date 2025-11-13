# 🧠 Arch RTL8822CE AutoFix

Self-healing Realtek RTL8822CE Wi-Fi driver setup for Arch-based systems.

## 🚀 Features
- Fixes missing Wi-Fi adapter detection on RTL8822CE chips
- Installs `rtw88-dkms-git` driver from AUR
- Auto-rebuilds driver after every kernel update via pacman hook
- Applies stability options (no deep sleep, no ASPM)
- Portable — run from GitHub on any new machine

## 🧩 Installation
```bash
git clone https://github.com/<yourusername>/arch-rtl8822ce-autofix.git
cd arch-rtl8822ce-autofix
bash setup.sh
