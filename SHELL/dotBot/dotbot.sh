#!/bin/bash
# local copy at `$HOME/.config/dotfiles`

set +x
dotfiles="$HOME/.config/dotfiles"
script_location=$( cd "$(dirname "$0")" ; pwd -P )
Upload () {
    cd $dotfiles
    cp $HOME/.dotfiles .dotfiles
    cp $HOME/.packages .packages
    eval $(grep -v '#' .dotfiles | grep -v '^$' | awk -F/ '{system("cp " $0 " ./")}')
    git add -A
    read -p "How do want to remember this state? [Commit Message]: " message
    git commit -m "$message"
    read -p "Save to remote? [Y/n] : " choice
    if [ choice == "n" ] || [ choice == "N" ]; then
        exit
    fi
    echo "Pushing the changes in dotfiles now."
    git push origin $distro
}

Download () {
    cd $dotfiles
    cp .dotfiles $HOME/.dotfiles

    #TODO handle copying files into folders that require sudo
    eval $(grep -v '#' .dotfiles | grep -v '^$' | awk -F/ '{system("cp " $NF " " $0)}')

    cp .packages $HOME/.packages
    cd $dotfiles
    packages=$(grep -v '#' .packages | grep -v '^$' | awk '{print $0}' ORS=" ")
    echo "Installing the following packages now: -"
    echo ${packages[@]}

    if [[ " ${archLike[@]} " =~ " $distro " ]]; then
        sudo pacman -S ${packages[@]}
    elif [[ " ${ubuntuLike[@]} " =~ " $distro " ]]; then
        sudo apt install ${packages[@]}
    elif [[ " ${mobileLike[@]} " =~ " $distro " ]]; then
        pkg install ${packages[@]}
    else
        echo "The specified distro is not supported yet. Contact brute4s99 over some social media."
        exit
    fi
}

Set_Up_Templates () {
    if [ ! -f $dotfiles/.dotfiles ]; then
        cp $script_location/.dotfiles_template $dotfiles/.dotfiles
        read -p "Looks like you are using me on a new distro. The script will open the .dotfiles file. Please list which dotfiles you want to maintain through this script."
        nano .dotfiles
    fi
    if [ ! -f $dotfiles/.packages ]; then
        cp $script_location/.packages_template $dotfiles/.packages
        read -p "Great! Now make a list of what packages to install everytime the configs are downloaded."
        nano .packages
    fi
}

# identify the distro
distro=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
if [[ $distro == "" ]]; then
    # ask the user for distro name in case we could not find the distro name from /etc/os-release
    echo "Couldn't detect your distro name"
    read -p "Enter your distro name [ubuntu | arch | mobile]: " distro
else
    echo "Your Linux Distro is: $distro"
fi


# make this folder if it does not exist right now
[ ! -d "$HOME/.config" ] && mkdir $HOME/.config

#TODO: List all supported distros here
declare -a archLike=(arch manjaro sabayon)
declare -a ubuntuLike=(ubuntu kubuntu pop!_os xubuntu lubuntu neon)
declare -a mobileLike=(mobile termux)


if [ ! -d $HOME/.oh-my-zsh ]; then
    # TODO: Find a better way to make zsh the default shell
    echo "zsh" >> ~/.bashrc
    echo "exit" >> ~/.bashrc

    # install oh-my-zsh
    cd ~
    curl -L http://install.ohmyz.sh | sh

    # add syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    chmod +x ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc

    # add auto-suggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "Terminal set-up done!"
fi

# get the repository where the dotfiles are maintained
if [ ! -d $dotfiles ]; then
    read -p "Want to download the personal configs now? [Y/n]: " choice
    if [[ $choice == "n" ]] || [[ $choice == "N" ]]; then
        exit
    fi
    echo "The following command will download your git repository named dotfiles."
    read -p " This operation may require your credentials if you have not set up SSH based access for your system."
    read -p "GitHub username [$USER] : " user
    if [[ $user == "" ]]; then
        user=$USER
    fi
    cd $HOME/.config
    git clone https://github.com/$user/dotfiles dotfiles
    if [ $? -eq 0 ]; then
        echo "Successfully cloned the repository."
    else
        echo "Please create a repository on your GitHub with this name: dotfiles"
        echo "DotBot uses this script to backup and maintain your dotfiles."
        echo "Once you have done that, please re-run the script to continue the setup process."
        exit
    fi
fi
cd $dotfiles
echo "Checking remote repository for updates. Please enter credentials if required."
git pull

echo "Restoring your settings from the configs folder now !"
if git checkout $distro; then
    # remote knows this distro
    Set_Up_Templates
    read -p "Feel free to make any changes to the dotfiles now if you want to."
    xdg-open ./ &> /dev/null
    read -p "PRESS ANY KEY TO CONTINUE"
    if [ ! -f /home/brute4s99/.dotfiles ]; then
        # system doesn't have dotbot
        Set_Up_Templates
    else
        # system does have dotbot already
        echo "Looks like you have already used dotbot on your system. Do you want to: -"
        echo "1) download configs from the repository? (replaces local configs)"
        echo "2) upload new configs from local? (replaces online configs)"
        read -p "[default = 1] : " choice
        if [[ $choice == "1" ]]; then
            Download
        else
            Upload
        fi
    fi
else
   # remote doesn't know this distro
    git checkout master
    git checkout -b $distro
    if [ ! -f /home/brute4s99/.dotfiles ]; then
        # system doesn't have dotbot already
        Set_Up_Templates
        cp $dotfiles/.dotfiles ~/.dotfiles
        cp $dotfiles/.packages ~/.packages
    fi
    # even if system does have dotbot already
    Upload
fi

echo "All Done!"
