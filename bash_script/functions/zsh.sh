#!/bin/bash

zsh () {
    figlet "ZSH"
    apt install -y zsh
    chsh -s $(which zsh) gon

    su - gon -c "sh -c '\
        sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"; \
    '"

    su - gon -c "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k"

    if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" /home/gon/.zshrc; then
        cat <<EOL >> /home/gon/.zshrc
ZSH_THEME="powerlevel10k/powerlevel10k"

export ZSH="/home/gon/.oh-my-zsh"

source \$ZSH/oh-my-zsh.sh

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user host dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs time)
EOL
    fi

    echo "${GREEN}Zsh et Powerlevel10K ont bien été installés${NC}."
}
