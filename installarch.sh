#!/bin/bash

sudo pacman -S --noconfirm --needed libreoffice-fresh libreoffice-fresh-pt-br

sudo pacman -S --noconfirm --needed startship ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-jetbrains-mono-nerd inter-font ttf-roboto ttf-ubuntu-font-family archlinux-wallpaper

sudo pacman -S --noconfirm --needed bat eza yazi tmux startship



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

# git clone https://github.com/LazyVim/starter ~/.config/nvim
