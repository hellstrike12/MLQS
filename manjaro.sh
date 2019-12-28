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
        for ((i=1; i<=$(echo ${info} | wc -c); i++)); do
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

input="vscode-extensions.txt"
( (
while IFS= read -r line
do
    code --install-extension "$line" &> /dev/null
done < "$input"
) ) &
spinner "Instalando extensões do VS Code..."
echo ' [OK] Instalando extensões do VS Code...' 

cp -f settings.json $HOME/.config/Code\ -\ OSS/User/ &
spinner "Atualizando configurações..."
echo ' [OK] Atualizando configurações...'

( (
input="python.txt"
while IFS= read -r line
do
    python -m pip install --user "$line" &> /dev/null
done < "$input"
) ) &
spinner "Instalando módulos do python..."
echo ' [OK] Instalando módulos do python...'

( (
input="npm.txt"
while IFS= read -r line
do
    npm install -g "$line" &> /dev/null
done < "$input"
) ) &
spinner "Instalando módulos do NPM..."
echo ' [OK] Instalando módulos do NPM...'

git config --global user.name "hellstrike12" &
git config --global user.email "hellstrike12@github.com" &
git config --global color.ui auto &
spinner "Configurando Git e GitHub..."
echo ' [OK] Configurando Git e GitHub...'

echo "      Hora do Show!"
code .
exit
