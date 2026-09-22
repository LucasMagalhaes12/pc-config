#!/bin/bash

## ISTALANDO PROGRAMAS ##
#Atualizando sistema
sudo pacman -Syu --noconfirm
# Instala os programas do repositorio flatpak
sudo pacman -S --noconfirm --needed base-devel git vim gufw fastfetch flatpak # ydotool gnome-terminal
# ferramentas Multimídia
sudo pacman -S --noconfirm --needed kdenlive gimp inkscape obs-studio audacity libreoffice-fresh libreoffice-fresh-pt-br
# Ferramentas de rede e utilitários
sudo pacman -S --noconfirm --needed plymouth less rsync # less samba power-profiles-daemon
# Fontes e papel de parede
sudo pacman -S --noconfirm --needed startship ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-jetbrains-mono-nerd inter-font ttf-roboto ttf-ubuntu-font-family archlinux-wallpaper
# Instalando Steam e ferramentas de joystick..."
sudo pacman -S --noconfirm --needed steam joystick gnome-chess gnome-sudoku
# Configurações do GNOME para extensões
sudo pacman -S --noconfirm --needed gnome-browser-connector
# Instalando utilitários
sudo pacman -S --noconfirm --needed bat eza yazi tmux blender godot startship
# Instalando docker e docker-compose
sudo pacman -S --noconfirm --needed docker docker-compose

## ATIVANDO SERVIÇOS ##
# Ativar serviços essenciais
sudo systemctl enable --now ufw.service
sudo systemctl enable --now bluetooth
# Ativando serviços docker
sudo systemctl enable --now docker.service

## FLATPAK ##
# Instalando Programas do Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub md.obsidian.Obsidian

## PYTHON ##
# Cria o ambiente virtual do Python
mkdir -p $HOME/Dev
python -m venv $HOME/Dev/.venv
source $HOME/Dev/.venv/bin/activate
pip3 install --upgrade pip
pip3 install pygame opencv-python
# pip3 install pygame pyGObject keyboard
deactivate

## AUR ##
mkdir -p $HOME/.local/bin/
cp scripts/aur.sh $HOME/.local/bin/aur
chmod +x $HOME/.local/bin/aur
$HOME/.local/bin/aur -ui

## CURSOR E APP INDICATOR ##
mkdir -p $HOME/.icons
cp -r config/Bibata-Modern-Ice $HOME/.icons
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com

## CONFIGURAÇÃO BASHRC ##
## Aliases para bat e eza
grep -qF "alias cat='bat --paging=never'" ~/.bashrc || echo "alias cat='bat --paging=never'" >>~/.bashrc
grep -qF "alias ls='eza --icons --group-directories-first'" ~/.bashrc || echo "alias ls='eza --icons --group-directories-first'" >>~/.bashrc
# Aliases para gerenciar o serviço do Samba
grep -qF 'alias smbon=' ~/.bashrc || echo 'alias smbon="sudo systemctl start smb.service nmb.service"' >>~/.bashrc
grep -qF 'alias smboff=' ~/.bashrc || echo 'alias smboff="sudo systemctl stop smb.service nmb.service"' >>~/.bashrc
# Aliases para gerenciar o ambiente virtual do Python
grep -qF 'alias venvon=' ~/.bashrc || echo 'alias venvon="source $HOME/Dev/.venv/bin/activate"' >>~/.bashrc
grep -qF 'alias venvoff=' ~/.bashrc || echo 'alias venvoff="deactivate"' >>~/.bashrc
grep -qF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
grep -qF 'eval "$(starship init bash)"' ~/.bashrc || echo 'eval "$(starship init bash)"' >>~/.bashrc
# configurações git
git config --global init.defaultBranch main
# git config --global user.email ""
# git config --global user.name ""

# Define o Google Chrome como navegador padrão
# xdg-settings set default-web-browser google-chrome.desktop

## Copiando Configuração GIMP e libreoffice ##
# cp -r config/GIMP $HOME/.config/
# cp -r config/libreoffice $HOME/.config/

## Atualizando o pacman.conf ##
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
sudo sed -i '/^#\[multilib\]/{s/^#//;n;s/^#//}' /etc/pacman.conf

# git clone https://github.com/LazyVim/starter ~/.config/nvim
