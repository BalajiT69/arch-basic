#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '/^# en_IN.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=en_IN.UTF-8" >> /etc/locale.conf
echo "archbt" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archbt.localdomain archbt" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

sudo reflector -c INDIA,SINGAPORE --age 12 --fastest 5 --latest 20 --protocol https  --sort rate --save /etc/pacman.d/mirrorlist

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools linux-lts-headers xdg-user-dirs xdg-utils gvfs gvfs-smb 
nfs-utils inetutils dnsutils bluez bluez-utils cups alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector 
sof-firmware alsa-firmware os-prober ntfs-3g terminus-font mpv filezilla firefox neofetch qbittorrent dkms intel-media-driver libva-utils mesa cantarell-fonts 
inter-font noto-fonts ttf-bitstream-vera ttf-caladea ttf-carlito ttf-cascadia-code ttf-croscore ttf-dejavu ttf-droid ttf-fira-code ttf-fira-mono ttf fira-sans 
ttf-inconsolata ttf-liberation ttf-opensans ttf-roboto ttf-ubuntu-font-family vlc gstreamer gstreamer-vaapi alsa-card-profiles alsa-lib alsa-plugins gst-libav 
gst-plugin-pipewire gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly libpulse wireplumber x264 x265 xvidcore curl iptables-nft dnsutils 
net-tools netctl nm-connection-editor nss-mdns wget cups-pdf cups-filters cups-pk-helper acpi acpi_call inotify-tools

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

sudo sed -i 's/MODULES=\(\)/MODULES=\(btrfs\)/' /etc/mkinitcpio.conf
mkinitcpio -P

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
#systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
#systemctl enable firewalld
#systemctl enable acpid

useradd -m balajit
echo balajit:password | chpasswd
usermod -aG sys,log,network,floppy,scanner,power,rfkill,users,video,storage,optical,lp,audio,wheel,adm balajit

#echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno
sed -i 's/^#%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers

#printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




