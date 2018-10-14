#!/bin/bash

OS=`cat /etc/os-release | grep "ID" | awk -F "[\"\"]" '{print $2}' | head -n1`
OSRELASE=`cat /etc/os-release | grep "VERSION_ID" | awk -F "[\"\"]" '{print $2}'`

if [[ $OS != "centos" ]] ; then
    echo "Sorry, your operate system is not CentOS."
    exit 1
fi

yum update -y

yum install -y git vim zsh

chsh -s /bin/zsh

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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

read -p "Install & Setup Nginx? (Y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] ; then
    nginxRepo="/etc/yum.repos.d/nginx.repo"
    echo "[nginx]" > $nginxRepo
    echo "name=nginx repo" >> $nginxRepo
    echo "baseurl=http://nginx.org/packages/$OS/$OSRELEASE/$basearch/" >> $nginxRepo
    echo "gpgcheck=0" >> $nginxRepo
    echo "enabled=1" >> $nginxRepo
    yum install -y nginx
    curl -fLo /etc/nginx/nginx.conf \
        https://raw.githubusercontent.com/m8524769/Dotfiles/master/nginx/nginx.conf
    iptables -I INPUT -p tcp --dport 80 -j ACCEPT
    systemctl enable nginx
fi

read -p "Setup ShadowSocksR? (Y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] ; then
    wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
    chmod +x shadowsocksR.sh
    ./shadowsocksR.sh 2>&1 | tee ShadowSocksR.log
    wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
    chmod +x bbr.sh
    ./bbr.sh
fi

