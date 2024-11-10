#!/bin/bash
sudo apt update -y
sudo apt upgrade -y

#Programas:
sudo apt install gufwg gnome-sudoku vlc

# Programação:
sudo apt install glade vim git xdotool python3-venv build-essential libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-image-dbg libsdl2-2.0-0 libsdl2-dev libsdl2-dbg

# Cria pasta Dev na home:
mkdir /home/$USER/Dev

# Instala Venv:
python3 -m venv /home/$USER/Dev/venv

# Adiciona um alias pra ativar venv
echo 'alias venvon="source ~/Dev/venv/bin/activate"' >> /home/$USER/.bashrc
echo 'alias venvoff="deactivate"' >> /home/$USER/.bashrc

#Instalar com Flatpack:
#Gimp, Darktable, Blender

#Instalar da Loja oficial:
#Steam, Vscode, Godot
