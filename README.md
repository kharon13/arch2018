###########################################################################
# Learn ArchLinux Install v0.1b (forked from ordanax/arch2018) 
###########################################################################

This script install ArchLinux XFCE + AUR + XFCE config. Also you can add own /home directory as well as XFCE config.

# Description
This script was not thought of as a normal installation with a large selection of DE, disk partitioning, etc.

His goal is to instantly deploy a system with all configs. The point is that you make all the changes in the script itself and get the option to quickly install ArchLinux XFCE + AUR + XFCE with your personal settings (assuming that you changed it for yourself, otherwise with my settings).

The script is based on my check sheet ArchLinux manual installation https://vk.cc/7JTg6U
MBR markup with BIOS. C UEFI yet no installation. In the plans.

Consists of 3 parts.

Video demonstration of the script https://www.youtube.com/watch?v=nvVF_qKDUeM

# Installation
1) Download and burn the Arch Linux ISO image on a USB flash drive https://www.archlinux.org/download/
2) Download and run the script with the command:

   ``` bash
   wget git.io/arch1.sh && sh arch1.sh
   ```
   The installation of the minimum system with DE XFCE starts.
   Part 2 is automatically installed and this is the basic installation of ArchLinux without programs.
3) 3rd part is optional. It installs the programs, AUR (yay), my XFCE configs.
   Pre-install wget with:
   
   ``` bash
   sudo pacman -S wget
   ```
   Installation of the 3rd part is done from the terminal with the command:
   
   ``` bash
   wget git.io/arch3.sh && sh arch3.sh
   ```
# Customize the script for yourself
You can fork this script. Change the disk layout to fit your needs, make a copy of your own XFCE kong, upload it to Github and quickly deploy your system.
Upon completion of the script, you get your ready and configured system with all configs. You only need to put it in order and that's all.
How and what to change is written in the comments in the script itself.

# ATTENTION!
The author is not responsible for any harm when using the script. Use it at your own risk or change to suit your personal needs.

Script overwrites the dev / sda disk in the system. Therefore, if you have valuable data on discs, save them. If you need to install next to Windows, then you need to first change the script and partition the disks. Otherwise, the data and Windows will be overwritten.

If automatic partitioning of disks does not suit you, then you first need to make disk partitioning and configure the script to suit your needs (programs, XFCE config, etc.)
See notes in the script itself.


# Script created:
Alexey Boiko / Алексей Бойко    -    https://vk.com/ordanax

Stepan Skriabin / Степан Скрябин  -  https://vk.com/zurg3

Michael Sarvilin / Михаил Сарвилин - https://vk.com/michael170707

Danil Antoshkin / Данил Антошкин -   https://vk.com/danil.antoshkin

Uri Poruncov / Юрий Порунцов    -    https://vk.com/poruncov

# Contact them 
Our Arch Linux Team https://vk.com/arch4u

Linux Chat https://t.me/linux4u

# Changelog
### 27.05.2019 Learn ArchLinux Install v0.1b (forked from ordanax/arch2018)
- change script for studying and setting it up for personal needs
- add new HDD for HOME&SWAP partition mount

