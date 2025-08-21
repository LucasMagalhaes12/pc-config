#!/bin/bash

# Atualiza a lista de pacotes e o sistema
sudo pacman -Syu

echo "Instalando neofetch vim git base-devel"
sudo pacman -S fastfetch vim git base-devel gnome-terminal xdotool gufw archlinux-wallpaper --noconfirm

echo "Instalando kdenlive, gimp, obs-studio e audacity..."
sudo pacman -S kdenlive gimp obs-studio audacity

echo "Instalando Steam e ferramentas de joystick..."
sudo pacman -S steam steam-devices joystick

# Sincroniza o sistema novamente antes de instalar do AUR
# sudo pacman -Syu --noconfirm

# Clona e instala o Google Chrome do AUR
# echo "Clonando e instalando Google Chrome do AUR..."
# cd ~/Downloads
# git clone https://aur.archlinux.org/google-chrome.git
# cd google-chrome
# makepkg -si --noconfirm
# cd ..

# Define o Google Chrome como navegador padrão
# echo "Definindo o Google Chrome como navegador padrão..."
# xdg-settings set default-web-browser google-chrome.desktop

# Configurações do GNOME para extensões
echo "Instalando o conector do GNOME para navegador..."
sudo pacman -S gnome-browser-connector --noconfirm

# Instalar o Flatpak Discord Obsidian


# Cria pasta Dev na home:
mkdir /home/$USER/Dev

# Instala Venv:
python3 -m venv /home/$USER/Dev/venv

# Adiciona um alias pra ativar venv
echo 'alias venvon="source ~/Dev/venv/bin/activate"' >> /home/$USER/.bashrc
echo 'alias venvoff="deactivate"' >> /home/$USER/.bashrc
