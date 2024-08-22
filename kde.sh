#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c INDIA,SINGAPORE --age 12 --fastest 5 --latest 20 --protocol https  --sort rate --save /etc/pacman.d/mirrorlist

#sudo firewall-cmd --add-port=1025-65535/tcp --permanent
#sudo firewall-cmd --add-port=1025-65535/udp --permanent
#sudo firewall-cmd --reload

git clone https://aur.archlinux.org/yay
cd yay/
makepkg -si --noconfirm

#pikaur -S --noconfirm system76-power
#sudo systemctl enable --now system76-power
#sudo system76-power graphics integrated
#pikaur -S --noconfirm auto-cpufreq
#sudo systemctl enable --now auto-cpufreq

sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xterm sddm plasma-meta breeze-grub breeze-plymouth flatpak-kcm plymouth-kcm plymouth 
papirus-icon-theme materia-kde ark dolphin dolphin-plugins gwenview isoimagewriter kate kcalc kcron kde-inotify-survey kdenetwork-filesharing kdf kdialog kfind 
kget kio-admin kio-gdrive kio-extras kmix konsole ksystemlog okular partitionmanager powerdevil spectacle bluedevil

#sudo flatpak install -y spotify

sudo systemctl enable sddm
#/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
#reboot
