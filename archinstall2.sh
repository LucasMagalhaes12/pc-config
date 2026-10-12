#!/bin/bash
set -e

echo "=== 1. OTIMIZANDO PACMAN ==="
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
sudo sed -i '/^#\[multilib\]/{s/^#//;n;s/^#//}' /etc/pacman.conf
grep -q "ILoveCandy" /etc/pacman.conf || sudo sed -i '/^Color/a ILoveCandy' /etc/pacman.conf
sudo pacman -Syu --noconfirm

echo "=== 2. INSTALANDO PACOTES BASE E UTILITÁRIOS ==="
sudo pacman -S --noconfirm --needed \
    base-devel git vim gufw fastfetch flatpak plymouth less rsync \
    bat eza yazi tmux blender godot starship docker docker-compose \
    gnome-browser-connector gnome-tweaks extension-manager

echo "=== 3. INSTALANDO APLICATIVOS MULTIMÍDIA E JOGOS ==="
sudo pacman -S --noconfirm --needed \
    kdenlive gimp inkscape obs-studio audacity \
    libreoffice-fresh libreoffice-fresh-pt-br \
    steam joystick gnome-chess gnome-sudoku firefox arduino-cli

echo "=== 4. INSTALANDO FONTES ==="
sudo pacman -S --noconfirm --needed \
    ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji \
    ttf-liberation ttf-jetbrains-mono-nerd inter-font ttf-roboto \
    ttf-ubuntu-font-family archlinux-wallpaper ttf-nerd-fonts-symbols \
    ttf-hack ttf-cascadia-code ttf-dejavu cantarell-fonts tex-gyre-fonts

fc-cache -fv

echo "=== 5. INSTALANDO BTRFS E BACKUP (SYSTEMD-BOOT) ==="
sudo pacman -S --noconfirm --needed snapper btrfs-assistant

echo "=== 6. ATIVANDO SERVIÇOS DO SISTEMA ==="
sudo systemctl enable --now ufw.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now docker.service

# Adiciona o usuário atual ao grupo docker para rodar containers sem sudo
sudo usermod -aG docker $USER

echo "=== 7. CONFIGURANDO FLATPAK ==="
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.discordapp.Discord md.obsidian.Obsidian

echo "=== 8. CONFIGURANDO AMBIENTE PYTHON ==="
mkdir -p "$HOME/Dev"
python -m venv "$HOME/Dev/.venv"
source "$HOME/Dev/.venv/bin/activate"
pip install --upgrade pip
pip install pygame opencv-python
deactivate

echo "=== 9. INSTALANDO AUR HELPER (SE EXISTIR SCRIPT) ==="
if [ -f "scripts/aur.sh" ]; then
    mkdir -p "$HOME/.local/bin/"
    cp scripts/aur.sh "$HOME/.local/bin/aur"
    chmod +x "$HOME/.local/bin/aur"
    "$HOME/.local/bin/aur" -c
    "$HOME/.local/bin/aur" -ui
fi

echo "=== 10. APLICANDO TEMAS E CURSORES ==="
mkdir -p "$HOME/.local/share/icons"
if [ -d "config/Bibata-Modern-Ice" ]; then
    cp -r config/Bibata-Modern-Ice "$HOME/.local/share/icons/"
    gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
fi

echo "=== 11. CONFIGURANDO ALIASES E BASHRC ==="
BASHRC="$HOME/.bashrc"

grep -qF "alias cat='bat --paging=never'" "$BASHRC" || echo "alias cat='bat --paging=never'" >> "$BASHRC"
grep -qF "alias ls='eza --icons --group-directories-first'" "$BASHRC" || echo "alias ls='eza --icons --group-directories-first'" >> "$BASHRC"
grep -qF 'alias smbon=' "$BASHRC" || echo 'alias smbon="sudo systemctl start smb.service nmb.service"' >> "$BASHRC"
grep -qF 'alias smboff=' "$BASHRC" || echo 'alias smboff="sudo systemctl stop smb.service nmb.service"' >> "$BASHRC"
grep -qF 'alias venvon=' "$BASHRC" || echo 'alias venvon="source $HOME/Dev/.venv/bin/activate"' >> "$BASHRC"
grep -qF 'alias venvoff=' "$BASHRC" || echo 'alias venvoff="deactivate"' >> "$BASHRC"
grep -qF 'export PATH="$HOME/.local/bin:$PATH"' "$BASHRC" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$BASHRC"
grep -qF 'eval "$(starship init bash)"' "$BASHRC" || echo 'eval "$(starship init bash)"' >> "$BASHRC"

git config --global init.defaultBranch main

echo "=== 12. CONFIGURAÇÃO INICIAL DO SNAPPER ==="
if [ ! -d "/.snapshots" ]; then
    sudo snapper -c root create-config /
    sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
fi

echo "=== INSTALAÇÃO CONCLUÍDA COM SUCESSO! ==="
