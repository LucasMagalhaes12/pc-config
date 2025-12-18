#!/bin/bash

sudo pacman -Syu --noconfirm

# Instala os programas do repositorio flatpak
sudo pacman -S --noconfirm --needed base-devel git vim gufw fastfetch xdotool #gnome-terminal
# Multimídia e ferramentas de áudio
sudo pacman -S --noconfirm --needed kdenlive gimp obs-studio audacity
# Ferramentas de rede e utilitários
sudo pacman -S --noconfirm --needed samba plymouth less tree # power-profiles-daemon
# Fontes e papel de parede
sudo pacman -S --noconfirm --needed ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-jetbrains-mono-nerd inter-font ttf-roboto inter-font ttf-ubuntu-font-family archlinux-wallpaper
# Instalando Steam e ferramentas de joystick..."
sudo pacman -S steam joystick gnome-chess gnome-sudoku

# Configurações do GNOME para extensões - Instalar manualmente pelo firefox o appindicator
sudo pacman -S gnome-browser-connector --noconfirm

# Ativar serviços essenciais
sudo systemctl enable ufw.service
sudo systemctl enable bluetooth --now

# Programas do Flatpak
# discord, obsidian


# Cria o ambiente virtual do Python
mkdir $HOME/Dev
python -m venv $HOME/Dev/.venv
# pip3 install pygame pyGObject keyboard

mkdir -p $HOME/.local/bin
cp aur.sh $HOME/.local/bin/aur
chmod +x $HOME/.local/bin/aur

mkdir $HOME/.icons
cp Bibata-Modern-Ice $HOME/.icons

# Configuração do .bashrc
# Aliases para gerenciar o serviço do Samba
echo 'alias smbon="sudo systemctl start smb.service nmb.service"' >> ~/.bashrc
echo 'alias smboff="sudo systemctl stop smb.service nmb.service"' >> ~/.bashrc
# Aliases para gerenciar o ambiente virtual do Python
echo 'alias venvon="source $HOME/Dev/.venv/bin/activate"' >> ~/.bashrc
echo 'alias venvoff="deactivate"' >> ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Configuração do prompt de comando com cores
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


# configurações git
git config --global init.defaultBranch main
# git config --global user.email ""
# git config --global user.name ""


# Programas do AUR
# Sincroniza o sistema novamente antes de instalar do AUR
# sudo pacman -Syu --noconfirm

mkdir $HOME/AUR

# Define o Google Chrome como navegador padrão
# xdg-settings set default-web-browser google-chrome.desktop


