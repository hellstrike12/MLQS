#!/bin/bash

# Author: Bryan Souza (hellstrike12)

function spinner() {
    local info="$1"
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while kill -0 $pid 2> /dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  $info" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        local reset="\b\b\b\b\b\b"
        for ((i=1; i<=$(echo $info | wc -c); i++)); do
            reset+="\b"
        done
        printf $reset
    done
    printf "    \b\b\b\b"
}


sudo pacman-mirrors --country Brazil &> /dev/null &&
sudo pacman -Syyu code nodejs npm shellcheck --noconfirm &> /dev/null &
spinner "Instalando VS Code, NodeJS, NPM e ShellCheck..."
echo ' [OK] Instalando VS Code, NodeJS, NPM e ShellCheck...'

code --install-extension ms-python.python &> /dev/null &&
code --install-extension dbaeumer.vscode-eslint &> /dev/null &&
code --install-extension eamodio.gitlens &> /dev/null &&
code --install-extension christian-kohler.path-intellisense &> /dev/null &&
code --install-extension CoenraadS.bracket-pair-colorizer &> /dev/null &&
code --install-extension ritwickdey.LiveServer &> /dev/null &&
code --install-extension esbenp.prettier-vscode &> /dev/null &&
code --install-extension vscode-icons-team.vscode-icons &> /dev/null &&
code --install-extension akamud.vscode-theme-onedark &> /dev/null &&
code --install-extension shd101wyy.markdown-preview-enhanced &> /dev/null &&
code --install-extension truman.autocomplate-shell &> /dev/null &&
code --install-extension timonwong.shellcheck &> /dev/null &
spinner "Instalando extensões do VS Code..."
echo ' [OK] Instalando extensões do VS Code...'

cp -f settings.json $HOME/.config/Code\ -\ OSS/User/ &
spinner "Atualizando configurações..."
echo ' [OK] Atualizando configurações...'

python -m pip install --user pylint autopep8 &> /dev/null &
spinner "Instalando módulos do python..."
echo ' [OK] Instalando módulos do python...'

sudo npm install -g eslint vsce &> /dev/null &
spinner "Instalando ESLint e VSCE..."
echo ' [OK] Instalando ESLint e VSCE...'

git config --global user.name "hellstrike12" &
git config --global user.email "hellstrike12@github.com" &
git config --global color.ui auto &
spinner "Configurando Git e GitHub..."
echo ' [OK] Configurando Git e GitHub...'

cd $HOME &&
git clone https://github.com/hellstrike12/python-game.git &> /dev/null &
spinner "Clonando repositório do GitHub [python-game]..."
echo ' [OK] Clonando repositório do GitHub [python-game]...'

echo "      Hora do Show!"
cd $HOME/python-game
code .
exit
