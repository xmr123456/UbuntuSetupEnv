#!/bin/sh

if [ $# -ne 4 ]; then
    echo "输入命令错误!!!（sudo $0 [当前用户名] [当前用户密码] [root用户名] [root用户密码]）" 
    exit 1
else 
    # 设置root密码
    echo "设置root密码"
    yes $4 | sudo passwd root

    # 更新清华源
    echo "更新清华源"
    sudo cp /etc/apt/sources.list /etc/apt/sources.list-bak
    sudo cat ./sources.list > /etc/apt/sources.list
    yes | sudo apt update

    yes | sudo apt-get upgrade

    # 安装ssh
    echo "安装ssh"
    sudo apt-get install openssh-server
    sudo service ssh start
    yes '\n' | ssh-keygen -t rsa

    # vim退格问题
    echo "vim退格问题"
    yes | sudo apt-get remove vim-common
    yes | sudo apt-get install vim

    # 安装samba
    echo "samba"
    sudo apt-get install samba
    sudo echo -e "\n[$1]\npath = /home/$1\nvalid users = $1\nbrowseable = yes\npublic = yes\nwritable = yes" >> /etc/samba/smb.conf
    yes $2 | sudo smbpasswd -a $1
    sudo /etc/init.d/smbd restart

    # 安装依赖包
    echo "安装依赖包"
    yes | sudo apt-get upgrade
    yes | sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib g++-multilib build-essential chrpath socat libsdl1.2-dev gcc g++
    yes | sudo apt-get install xterm sed cvs subversion coreutils texi2html docbook-utils help2man make desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake groff curl lzop asciidoc python3-pip libssl-dev
    yes | sudo apt-get install python2.7 git ssh liblz4-tool expect patchelf binfmt-support qemu-user-static live-build bison flex fakeroot cmake device-tree-compiler libncurses-dev python3-pyelftools vim mtd-utils
    yes | sudo apt-get install repo gitk git-gui gcc-arm-linux-gnueabihf u-boot-tools gcc-aarch64-linux-gnu mtools parted libudev-dev libusb-1.0-0-dev autotools-dev libsigsegv2 m4 intltool libdrm-dev binutils bash patch gzip bzip2 perl tar cpio file bc libncurses5 libglib2.0-dev libgtk2.0-dev libglade2-dev rsync openssh-client w3m dblatex graphviz libc6:i386 libtool keychain expect-dev
    yes | sudo apt-get install android-tools-adb net-tools tree minicom
    yes | sudo apt-get install gnupg gperf zip zlib1g-dev libc6-dev-i386 lib32ncurses5-dev libx11-dev lib32z-dev ccache libxml2-utils xsltproc libfdt-dev libfdt1 libboost-all-dev
    yes | sudo apt-get install python3 python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa
fi