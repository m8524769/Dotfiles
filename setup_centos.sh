#!/bin/bash

source /etc/os-release

yum -y update

yum -y install git vim zsh gcc

chsh -s /bin/zsh

curl -fLo ~/.zshrc \
    https://raw.githubusercontent.com/m8524769/Dotfiles/master/.zshrc

curl -fLo ~/.vimrc \
    https://raw.githubusercontent.com/m8524769/Dotfiles/master/.vimrc_for_server

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.vim/colors/molokai2.vim --create-dirs \
    https://raw.githubusercontent.com/m8524769/Dotfiles/master/others/molokai2.vim

read -p "Install & Setup Nginx? (Y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    {
        echo \[nginx\]
        echo name=nginx repo
        echo "baseurl=http://nginx.org/packages/$ID/$VERSION_ID/\$basearch/"
        echo gpgcheck=0
        echo enabled=1
    } >> /etc/yum.repos.d/nginx.repo
    yum -y install nginx
    curl -fLo /etc/nginx/nginx.conf \
        https://raw.githubusercontent.com/m8524769/Dotfiles/master/nginx/nginx.conf
    iptables -I INPUT -p tcp --dport 80 -j ACCEPT
    systemctl enable nginx
fi

read -p "Install NodeJS? (Y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
    yum -y install nodejs
fi

read -p "Setup ShadowSocksR? (Y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
    chmod +x shadowsocksR.sh
    ./shadowsocksR.sh 2>&1 | tee ShadowSocksR.log
    wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
    chmod +x bbr.sh
    ./bbr.sh
fi

read -p "Setup ShadowSocks? (Y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
    chmod +x shadowsocks.sh
    ./shadowsocks.sh 2>&1 | tee ShadowSocks.log
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    ~/.oh-my-zsh/plugins/zsh-autosuggestions

