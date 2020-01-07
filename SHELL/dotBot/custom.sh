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