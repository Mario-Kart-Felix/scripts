#!/bin/bash
# local copy at `$HOME/.config/dotfiles`
# TODO: switch from folders to git branches
# TODO: add a list of ad-hoc packages


dotfiles="$HOME/.config/dotfiles"

Setup () {
    [! -d "$HOME/.config" ] && mkdir ~/.config
    cd ~/.config
    read -p "GitHub username to load your dotfiles [$USER] : " user
    if [[ $user=="" ]]; then
        user=$USER
    fi
    git clone https://github.com/$user/dotfiles dotfiles

    distro=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    if [[ $distro == "" ]]; then
        # ask the user for distro in case we could not find the ID
        echo "Couldn't detect your distro"
        read -p "Enter your distro name [ubuntu | arch | mobile]: " distro
    else
        echo "Your Linux Distro is: $distro\n"
    fi
    # save the distro information for Sync
    [ -d "$dotfiles/.distro" ] && rm $dotfiles/.distro
    echo $distro > $dotfiles/.distro

    if [[ $distro == ubuntu ]]; then
        sudo apt install zsh curl git wakeonlan
    elif [[ $distro == arch ]]; then
        sudo pacman -S zsh curl git
    elif [[ $distro == mobile ]]; then
        pkg install zsh curl git
    elif [[ $distro == "" ]]; then
        echo "distro name not specified : [ubuntu | arch | mobile]\n"
        exit
    else
        echo "The specified distro is not supported yet.\n"
        exit
    fi

    # TODO: Find a better way to make zsh the default shell
    echo "zsh" >> ~/.bashrc
    echo "exit" >> ~/.bashrc

    # install oh-my-zsh
    cd ~
    curl -L http://install.ohmyz.sh | sh

    # add syntax-highlighting
    cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    chmod +x ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # add auto-suggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "Terminal set-up done!"
    touch $HOME/.dotfiles
    read -p "Want to restore the personal configs now? [Y/n]: " choice
    if [[ $choice == "n" ]] || [[ $choice == "N" ]]; then
        exit
    fi
    echo "Restoring my settings from the configs folder now !"
    cd "$dotfiles/$distro"
    echo $(ls *) >> $HOME/.dotfiles
    echo $(ls .*) >> $HOME/.dotfiles
    cp -rT $HOME/.config/dotfiles/$distro $HOME/
}

Sync () {
    distro=$(cat $dotfiles/.distro)
    if [! -d "$dotfiles" ]; then
        Setup
    fi
    files=$(cat $HOME/.dotfiles)
    for file in files; do
        rsync $HOME/$file $dotfiles/$distro/
    done
    git add configs/$distro
    read -p "How do want to remember this state? [Commit Message]: " message
    git commit -m "$message"
    read -p "Save to remote? [Y/n] : " choice
    if [ choice == "n" ] || [ choice == "N" ]; then
        exit
    fi
    echo "\nPushing the changes in dotfiles now.\n"
    git push origin master
}

if [ -d $dotfiles ]; then
    Sync
else
    Setup
fi

echo "All Done!"

