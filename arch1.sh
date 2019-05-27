#!/bin/bash

# Arch Linux Fast Install - https://github.com/ordanax/arch2018
# Fast install ArchLinux (cfg XFCE, themes, soft & etc.).

# Developed by:
# Alexey Boiko https://vk.com/ordanax
# Stepan Skbyabin https://vk.com/zurg3
# Michael Sarvilin https://vk.com/michael170707
# Danil Antoshkin https://vk.com/danil.antoshkin
# Uri Poruntcov https://vk.com/poruncov
# Thank you so much guys for your work

loadkeys ru
setfont cyr-sun16
echo 'Script based on checklist Alexey Boiko for install ArchLinux'
echo 'Url on checklist - vk.com/arch4u'

echo '2.3 Sync on system clock'
timedatectl set-ntp true

#i want GPT
echo '2.4 Create Partition on ssd'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +100M;

  echo n;
  echo;
  echo;
  echo;
  echo +20G;

  echo w;
) | fdisk /dev/sda
#I do not understand
#if i do this 

echo 'Create Partition on HDD'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +16024M;

  echo n;
  echo p;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sdb
fdisk -l

#Needed change for EFI system

echo '2.4.2 Disk format'
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
mkswap /dev/sdb1 -L swap
mkfs.ext4  /dev/sdb2 -L home

echo '2.4.3 Disk mount'
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sdb1
mount /dev/sdb2 /mnt/home

echo '3.1 Change mirror. Use Yandex mirror'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo '3.2 Install Base package'
pacstrap /mnt base base-devel

echo '3.3 System setup'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL git.io/arch2.sh)"
