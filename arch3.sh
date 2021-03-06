#!/bin/bash
#rm -rf ~/.config/xfce4/*
#mkdir ~/Downloads
#cd ~/Downloads

echo 'install AUR (yay)'
sudo pacman -Syu
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Create directories'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Install soft'
sudo pacman -S firefox ufw qt4 f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio --noconfirm

echo 'Do u want install this (OBS, VeraCrypt, FreeMind, FileZilla, Gimp, LibreOffice, KdeLive, Audacity, ScreenFetch, VLC, QBittorent, Gnome Calc, CherryTree,GxNeur, TimeShift, FlameShot, xFlux, Sublime?'
read -p "1 - Yes, 0 - No: " prog_set
if [[ $prog_set == 1 ]]; then
  sudo pacman -S obs-studio doublecmd-gtk2 veracrypt vlc freemind filezilla gimp libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qbittorrent gnome-calculator --noconfirm
  yay -S cherrytree gxneur-devel-git timeshift flameshot-git xflux sublime-text-dev hunspell-ru pamac-aur --noconfirm 
  gpg --keyserver pgp.mit.edu --recv-keys FC918B335044912E
  yay -S dropbox --noconfirm
elif [[ $prog_set == 0 ]]; then
  echo 'Soft install canceled.'
fi

echo 'Download & install CFG and themes for XFCE?'
read -p "1 - Yes, 0 - No: " xfce_set
if [[ $xfce_set == 1 ]]; then
  echo 'Download and install settings XFCE'
  # Чтобы сделать копию ваших настоек XFCE перейдите в домашнюю директорию ~/username открйте в этой категории терминал и выполните команду ниже.
  # tar -czf xfce4.tar.gz .config/xfce4
  # Выгрузите архив в интернет и скорректируйте ссылку на XFCE файл заменив ссылку на свою.
  # wget git.io/xfce4.tar.gz
  wget https://github.com/ordanax/backup/blob/master/xfce4.tar.gz?raw=true
  sudo rm -rf ~/.config/xfce4/panel/
  sudo rm -rf ~/.config/xfce4/*
  sudo tar -xzf xfce4.tar.gz -C ~/
  echo 'Install themes'
  yay -S osx-arc-shadow papirus-maia-icon-theme-git breeze-default-cursor-theme --noconfirm
  sudo pacman -S capitaine-cursors
  
  echo 'New logos ArchLinux in menu'
  wget git.io/arch_logo.png
  sudo mv -f ~/Downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

  echo 'Set wallpaper'
  wget git.io/bg.jpg
  sudo rm -rf /usr/share/backgrounds/xfce/* #old wallpaper remove
  sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg
elif [[ $xfce_set == 0 ]]; then
  echo 'Install CFG is skipted.'
fi 
  
echo 'Download & install CFG and themes for Openbox?'
read -p "1 - Yes, 0 - No: " openbox_set
if [[ $openbox_set == 1 ]]; then
  echo 'Download and install settings Openbox'
  #wget git.io/openbox.tar.gz
  #sudo tar -xzf openbox.tar.gz -C ~/
  #wget git.io/tint2.tar.gz
  #sudo tar -xzf tint2.tar.gz -C ~/
  wget https://github.com/ordanax/arch2018/raw/master/attach/config.tar.gz
  sudo tar -xzf config.tar.gz -C ~/
  yay -S obconf obmenu-generator obkey-git lxappearance-obconf tint2 nitrogen thunar mousepad wmctrl compton papirus-icon-theme
  sudo pacman -S capitaine-cursors
elif [[ $openbox_set == 0 ]]; then
  echo 'Soft install canceled.'
fi  

echo 'Hide GRUB menu for choose system?'
read -p "1 - Yes, 0 - No: " grub_set
if [[ $grub_set == 1 ]]; then
  wget git.io/grub.tar.gz
  sudo tar -xzf grub.tar.gz -C /
  sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $grub_set == 0 ]]; then
  echo 'Skipted.'
fi

echo 'Install conky?'
read -p "1 - Yes, 0 - No: " conky_set
if [[ $conky_set == 1 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget git.io/conky.tar.gz
  tar -xzf conky.tar.gz -C $HOME/
elif [[ $conky_set == 0 ]]; then
  echo 'Install conky is skipted.'
fi

echo 'Gufw enable'
sudo ufw enable

echo 'Add in autologon system:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/arch3.sh

echo 'Setup compete!'
