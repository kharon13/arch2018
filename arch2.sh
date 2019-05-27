#!/bin/bash
read -p "Press type Hostname: " hostname
read -p "Press type Username: " username

echo 'Set hostname'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Asia/Barnaul /etc/localtime

echo '3.4 Add ru_RU locale'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Update curently system local'
locale-gen

echo 'Set LNG systems'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo 'Change KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Create bootable RAM disk'
mkinitcpio -p linux

echo '3.5 Install GRUB'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda

echo 'Update grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

#echo 'Install program for Wi-fi'
#pacman -S dialog wpa_supplicant --noconfirm 

echo 'Add user'
useradd -m -g users -G wheel -s /bin/bash $username

echo 'Create root pass'
passwd

echo 'Set user password'
passwd $username

echo 'Install SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Uncommit rep multilib for work 32-bit apps in 64-bit system.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo "Install Arch Linux on vitrual box?"
read -p "1 - Yes, 0 - No: " vm_setting
if [[ $vm_setting == 0 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit"
elif [[ $vm_setting == 1 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils"
fi

echo 'GUI & driver install'
pacman -S $gui_install

echo "Choose DE?"
#read -p "1 - XFCE, 2 - KDE, 3 - Openbox: " vm_setting
read -p "1 - XFCE, 2 - KDE: " vm_setting
if [[ $vm_setting == 1 ]]; then
  pacman -S xfce4 xfce4-goodies --noconfirm
elif [[ $vm_setting == 2 ]]; then
  pacman -Sy plasma-meta kdebase --noconfirm
#elif [[ $vm_setting == 3 ]]; then  
 # pacman -S  openbox xfce4-terminal
fi

echo 'Choose DM ?'
read -p "1 - sddm (for Openbox no logon menu, not install), 2 - lxdm: " dm_setting
if [[ $dm_setting == 1 ]]; then
  pacman -Sy sddm sddm-kcm --noconfirm
  systemctl enable sddm.service -f
elif [[ $dm_setting == 2 ]]; then
  pacman -S lxdm --noconfirm
  systemctl enable lxdm
fi

echo 'Set fonts'
pacman -S ttf-liberation ttf-dejavu --noconfirm 

echo 'Set network'
pacman -S networkmanager network-manager-applet ppp --noconfirm

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager

echo 'Setup complete! Restart system!'
echo 'Если хотите подключить AUR, установить конфиги XFCE, тогда после перезагрузки и входа в систему, установите wget (sudo pacman -S wget) и выполните команду:'
echo 'wget git.io/arch3.sh && sh arch3.sh'
exit
