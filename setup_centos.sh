#!/bin/bash

yum update

yum install -y git vim zsh

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl -fLo ~/.zshrc \
    https://raw.githubusercontent.com/m8524769/Dotfiles/master/.zshrc

curl -fLo ~/.vimrc \
    https://raw.githubusercontent.com/m8524769/Dotfiles/master/.vimrc_for_server

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.vim/colors/molokai2.vim --create-dirs \
    https://raw.githubusercontent.com/m8524769/Dotfiles/master/others/molokai2.vim

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    ~/.oh-my-zsh/plugins/zsh-autosuggestions

