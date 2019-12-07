#!/bin/bash

askUserYesNoQuestion() {
    response=false

    question=$1

    read -p "$question (y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        response=true
    fi

    return response
}


what_to_install="$1"

# Get this script's directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Create a temp dir for this script
temp_dir="$script_dir/temp"
if ! [[ -e "$temp_dir" ]]; then
    mkdir "$script_dir/temp"
fi

# Update apt
sudo apt-get update

# Install git commands
# Overwrite existing user's .gitconfig
src_gitconfig_path="$script_dir/../config/.gitconfig.for_user_profile"
dst_gitconfig_path="$HOME/.gitconfig"
if ! [[ -e "$dst_gitconfig_path" ]]; then
    cp "$src_gitconfig_path" "$dst_gitconfig_path"
fi

# Install light-weight essentials
sudo apt-get install -y zsh
sudo apt-get install -y vim
sudo apt-get install -y curl
sudo apt-get install -y silversearcher-ag
sudo snap install tree

# Install oh-my-zsh
# Only install if it's not already there
zsh_profile_path="$HOME/.zshrc"
if ! [[ -e "$zsh_profile_path" ]]; then
    curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
fi

# TODO: Modify .zshrc theme to jtriley for WSL

# Install awesome vim config
# Only install if it's not already there
amix_vimrc_path="$HOME/.vim_runtime"
if ! [[ -e "$amix_vimrc_path" ]]; then
    git clone --depth=1 https://github.com/amix/vimrc.git "$amix_vimrc_path"
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# Install fzf
fzf_path="$HOME/.fzf"
if ! [[ -e "$fzf_path" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$fzf_path"
    yes | "$HOME/.fzf/install"
fi

# Install C++
install_cpp=false
if [[ what_to_install == "all" ]]; then
    install_cpp=true
else
    install_cpp=askUserYesNoQuestion "Install C++?"
fi

if [[ install_cpp == true ]]; then
    sudo apt-get install -y g++ cmake
fi

# Install bonus packages
install_bonuses=false
if [[ what_to_install == "all" ]]; then
    install_bonuses=true
else
    install_bonuses=askUserYesNoQuestion "Install bonus packages?"
fi

if [[ $install_bonuses == true ]]; then
    sudo apt-get install -y meld
fi

#####################################################
## Stuff that requires manual intervention
#####################################################

# Install Anaconda
install_conda=false
if [[ what_to_install == "all" ]]; then
    install_conda=true
else
    install_conda=askUserYesNoQuestion "Install bonus Anaconda for python?"
fi

if [[ $install_conda == true ]]; then
    anaconda_installer_path="$script_dir/temp/Miniconda3-latest-Linux-x86_64.sh"
    if ! [[ -e "$anaconda_installer_path" ]]; then
        wget -O "$anaconda_installer_path" https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
        sh "$anaconda_installer_path"
    fi
fi

