# Arch Linux Install

## Main References

[Official Wiki](https://wiki.archlinux.org/title/installation_guide)

[DistroTube Install Guide](https://www.youtube.com/watch?v=PQgyW10xD8s&ab_channel=DistroTube)

[Luke Smith Install Guide](https://www.youtube.com/watch?v=4PBqpX0_UOc&ab_channel=LukeSmith)

[DistroTube Post Install](https://www.youtube.com/watch?v=PQgyW10xD8s&ab_channel=DistroTube)

[Luke Smith Post Install](https://www.youtube.com/watch?v=nSHOb8YU9Gw&ab_channel=LukeSmith)


## Install
```
NOTE: This as a UEFI installation.
```

### Pre-Install7

After booting from the flash drive we should:

Check if the following folder is available, if not you should disable `Secure Boot` on the motherboard.
```
ls /sys/firmware/efi/efivars
```

Then:
- set the keyboard to abnt-2 so we can type properly `loadkeys br-abnt2` or `loadkeys br-latin1-us`
- update the system clock `timedatectl set-ntp true` and `timedatectl set-timezone Brazil/East`
- partition the disk (if needed follow the references) (`fdisk -l` to check the current state)
- mount the partitions

```
mount /dev/sda3 /mnt
swapon /dev/sda2
```

> Here i'm assuming we have a boot partition in `sda1`, a swap partition in
`sda2` and the root one in `sda3`

To setup wifi run `iwctl` (assuming that `device list` will return `wlan0` as the available wifi device)

```
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect SSID
```

### Install

The first command will install the OS (and vim and more basic stuff),
the second one will write the `fstab` so the computer knowns how to boot the
computer.

```
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
```

> You might have to update the keyring to prevent corrupted packages `pacman -Sy archlinux-keyring`

Now we change root into the newly installed system (leaving de flash drive) and
we setup again the locale and clock stuff (last time we did on the flash drive,
now we are permanently setting up the system).

```
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
```

or 

```
echo "KEYMAP=br-latin1-us" >> /etc/vconsole.conf
```

Now set the machine's name, the root password and the main user and `sudo`
capabilities

```
echo "myhostname" >> /etc/hostname
passwd
useradd -m rzuquim
passwd rzuquim
usermod -aG wheel,audio,video,optical,storage rzuquim
pacman -S sudo
```

Also edit the file `/etc/sudoers` to ensure the grop wheel is on the sudoers list

### Boot manager
Let's install and configure grub as our boot manager
To ensure stability the Arch Wiki recomends updating the processor microcode (intel or amd)

```
pacman -S grub efibootmgr dosfstools os-prober mtools intel-ucode
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
```

### Network
Now we setup the network installing a network manager and enabling it as a
`systemd` service.

```
pacman -S networkmanager
systemctl enable NetworkManager
```

Let's also set the loopback addresses on the `/etc/hosts` table

```
127.0.0.1        localhost
::1              localhost
127.0.1.1        myhostname.localdomain myhostname
```

### Bluetooth
Could not make it work

[Arch wiki reference](https://wiki.archlinux.org/title/bluetooth)

```
paru -S bluez bluez-utils
systemctl enable bluetooth.service
```

To pair devices 
```
bluetoothctl
```

--------------

## Post Install

### Wifi

To find out the device name (wlan0, wlp2s0)
```
sudo dmesg | grep wifi
```

Then
```
sudo nmcli radio wifi on
nmcli dev wifi list
nmcli dev wifi connect <SSID> password <password> ifname wlan0
```

### Audio

Instal ALSA an use `alsamixer` to setup the volume.

```
pacman -S alsa-utils
```

### Enabling AUR with [Paru](https://github.com/Morganamilo/paru)
```
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
```

### Installing video driver

To check the model of the graphics card run `lspci`

[NVIDIA](https://wiki.archlinux.org/title/NVIDIA) - PCs
```
sudo pacman -S TODO
```

[NVIDIA](https://wiki.archlinux.org/title/NVIDIA) - Z2
```
sudo pacman -S xf86-video-ati
```

[Intel Graphics](`https://wiki.archlinux.org/title/intel_graphics`) notebook

> lib32-mesa is available on the `[multilib]` repo. First we must edit `/etc/pacman.conf` and uncomment lines
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then we should run
```
sudo pacman -Sy
sudo pacman -S mesa lib32-mesa
```
### Installing X11 and Window Manager

`xorg`: display server
`nitrogen`: wall paper manager
```
sudo paru -S xorg xorg-xinit nitrogen picom
sudo paru -S xmonad xmonad-contrib xmobar dmenu alacritty
```

// TODO: add this on install script to set keyboard layout to abnt2
sudo cp arch/etc/10-evdev.conf /etc/X11/xorg.conf.d/10-evdev.conf

//TODO: put on repo ~/.config/.xinitrc
//TODO: startx on bash_profile


### Installing Brave
```
paru -S brave-bin
```


### Tools
paru -S bat exa fd nvim
paru -S nerd-fonts-cascadia-code
paru -S zsh zsh-theme-powerlevel10k-git

TODO: edit font ~/.config/fontconfig/fonts.conf

paru -S xdg-util


# docker setup
paru -S docker
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
sudo systemctl start docker


> For quality of life (since I'm used to bing CAPSLOCK to ESC I'm doing it as soon as possible)

```
 setxkbmap -option caps:escape
```

