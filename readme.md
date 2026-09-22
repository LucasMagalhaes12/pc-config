# Script de Pós-Instalação para Arch Linux (`installarch.sh`)

Este script em Bash automatiza a pós-instalação e configuração de um ambiente de desenvolvimento e multimídia no **Arch Linux** (com foco no ambiente desktop **GNOME**). Ele realiza a atualização do sistema, instalação de softwares essenciais, configuração de serviços, ambiente virtual Python, aliases no shell e ajustes de personalização visual.

---

## 🛠️ O que o script faz?

O script executa as seguintes etapas sequencialmente:

### 1. Atualização e Instalação de Pacotes (`pacman`)

Atualiza a base de dados do repositório e instala programas categorizados:

* **Utilitários do Sistema e CLI:** `base-devel`, `git`, `vim`, `gufw` (firewall), `fastfetch`, `flatpak`, `plymouth`, `less`, `rsync`, `bat`, `eza`, `yazi`, `tmux`.
* **Prompt e Desenvolvimento:** `starship`, `docker`, `docker-compose`.
* **Multimídia e Design:** `kdenlive`, `gimp`, `inkscape`, `obs-studio`, `audacity`, `blender`, `godot`.
* **Produtividade e Jogos:** `libreoffice-fresh`, `steam`, `joystick`, `gnome-chess`, `gnome-sudoku`.
* **Fontes e Papéis de Parede:** `ttf-fira-code`, `noto-fonts`, `ttf-jetbrains-mono-nerd`, `inter-font`, `ttf-roboto`, `ttf-ubuntu-font-family`, `archlinux-wallpaper`.
* **Integração Desktop:** `gnome-browser-connector` (suporte a extensões no navegador para GNOME).

### 2. Ativação de Serviços do Sistema (`systemd`)

Habilita e inicializa os seguintes daemons/serviços em segundo plano:

* Firewall Uncomplicating (`ufw.service`)
* Suporte a Bluetooth (`bluetooth.service`)
* Serviço de Containers (`docker.service`)

### 3. Gerenciador de Pacotes Flatpak

Configura o repositório **Flathub** e instala aplicações em sandbox:

* **Discord** (`com.discordapp.Discord`)
* **Obsidian** (`md.obsidian.Obsidian`)

### 4. Configuração do Ambiente Python

Cria a estrutura de diretórios e o ambiente virtual de desenvolvimento:

* Cria o diretório e o venv em `$HOME/Dev/.venv`.
* Atualiza o `pip`.
* Instala as bibliotecas `pygame` e `opencv-python`.

### 5. Instalação do Auxiliar AUR

* Copia o script local `scripts/aur.sh` para `$HOME/.local/bin/aur`.
* Aplica permissão de execução (`chmod +x`).
* Executa a ferramenta com a flag `-ui`.

### 6. Personalização do Sistema e Cursor

* Instala o tema de cursor **Bibata-Modern-Ice** na pasta `$HOME/.icons`.
* Define o tema de cursor globalmente no GNOME usando `gsettings`.
* Habilita a extensão de ícones na barra de status do GNOME (`appindicatorsupport`).

### 7. Customização do Terminal (`~/.bashrc`)

Adiciona automaticamente aliases e configurações no arquivo `.bashrc`:

* `cat` -> redirecionado para `bat --paging=never` (visualizador com syntax highlighting).
* `ls` -> redirecionado para `eza --icons --group-directories-first` (listagem moderna com ícones).
* `smbon` / `smboff` -> atalhos para iniciar/parar os serviços do Samba.
* `venvon` / `venvoff` -> atalhos para ativar/desativar o ambiente virtual Python.
* Inclui `$HOME/.local/bin` no `PATH` do sistema.
* Inicializa o prompt customizado **Starship**.
* Define `main` como a branch padrão do Git.

### 8. Otimizações no Gerenciador de Pacotes (`/etc/pacman.conf`)

* Ativa saída de texto colorida (`Color`).
* Habilita downloads paralelos de até 5 pacotes simultâneos (`ParallelDownloads = 5`).
* Habilita o repositório `[multilib]` (necessário para aplicativos 32-bits como a Steam).

---

## 📋 Estrutura de Arquivos Necessária

Para que o script funcione corretamente, certifique-se de que a estrutura do seu projeto/repositório possui a seguinte organização:

```text
.
├── installarch.sh
├── scripts/
│   └── aur.sh
└── config/
    └── Bibata-Modern-Ice/
```

---

## 🚀 Como Executar

1. Dê permissão de execução para o script no terminal:
   ```bash
   chmod +x installarch.sh
   ```

2. Execute o script:
   ```bash
   ./installarch.sh
   ```

> **Aviso:** O script solicita privilégios de superusuário (`sudo`) para a instalação dos pacotes e ativação dos serviços do sistema.