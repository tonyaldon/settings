# About
My linux (ubuntu) user configuration.

This configuration works on linux ubuntu 16.04 LTS (maybe later
release too but not tested).

Meaning of the directories:
1. `emacs.d` contains my emacs configuration,
2. `i3` contains my i3 configuration,
3. `keyboard-layout` contains my keyboard layout (takbl),
4. `uconfig` contains other user configuration files.

# Motivation 
1. Good management of my workspace to work efficiently.
2. Share my setting system.

# Setup

To grab all the dependencies, run the command:

	git clone --recurse-submodules https://github.com/tonyaldon/settings.git

Or to grab all dependencies, set remote url to ssh protocol and get submodules as 
stand alone repositories, run the commands:

	git clone https://github.com/tonyaldon/settings.git
	cd path/to/settings
	make git_repositories

# Links

To make appropriate symbolinc links for `i3`, `.emacs.d` and
`uconfig`, run the commands:

	cd path/to/settings
	make links

Symbolic links are done with [stow](https://www.gnu.org/software/stow/).

If you want to delete previous links made by running `make links`, run the commands:

	cd path/to/settings
	make clean_links	

# Keyboard layout
To install `takbl` keyboard layout, see 
[keyboard layout](https://github.com/tonyaldon/keyboard-layout/tree/c3b2c099c2f3123e14c8488d0b7c02ebb0f52990) README.

# SSH

SSH keys must be in the `~/.ssh` directory. So assuming that on your usb device your keys
are in the directory `ssh` and the plugged usb device is named `sdb1`, run the following
commands:

	sudo mount /dev/sdb1 /mnt
	sudo cp -r /mnt/ssh ~/.ssh
	sudo umount /dev/sdb1

# Audio

1. If you get some trouble with the audio (audio cards), you can get informations by
running the command:

	pulseaudio -vvv

2. The audio problem I've had was that I did have any sound. Running the command
`pulseaudio -vvv` gave me:

	E: [pulseaudio] pid.c: Daemon already running.
	E: [pulseaudio] main.c: pa_pid_file_create() failed.

I solve the problem by `removing` the `pulse` user config file and `rebooting` the
system. Concretely, I ran the following commands:

	rm -r ~/.config/pulse
	reboot

See the [stackexchange discussion](https://askubuntu.com/questions/1056153/pulseaudio-not-working-daemon-already-running-and-no-permission-for-home-folder)
to get more information.

# Laptop lid switch

To handle how the system deal with the laptop lid, tweak the file
`/etc/systemd/logind.conf`.

If you want your laptop to be still running when you close the lid (for instance
to use another monitor), uncomment the line `#HandleLidSwitch=suspend` of the file
`/etc/systemd/logind.conf` and change the argument `suspend` by `ignore`. So you end
with the line `HandleLidSwitch=ignore` among the others.

Restart the `Systemd` service to apply changes by running the command:

	systemctl restart systemd-logind.service

See [How to change lid close action](https://tipsonubuntu.com/2018/04/28/change-lid-close-action-ubuntu-18-04-lts/)
to get more information.

# Monitors

I use to have my laptop monitor disable and the other enable. To do this,
get the name of your laptop monitor with `xrandr` command. For me it's `eDP-1`.
So to disable my laptop monitor `eDP-1`, I run the command:

	xrandr --output eDP-1 --off

Note: As I'm running `i3` window management, the previous command is perform
in the `i3` config file.

To reset these settings, run the command:

	xrandr --auto

# Chromium Browser

I'm using [Chromium](https://www.chromium.org/Home) as browser. Run this command to install it:

	sudo apt install chromium-browser

## Chromium extensions

I'm using it with the following extensions:

1. [Saka](https://chrome.google.com/webstore/detail/saka/nbdfpcokndmapcollfpjdpjlabnibjdi): elegent tab search, selection, and beyond.
2. [Saka Key](https://chrome.google.com/webstore/detail/saka-key/hhhpdkekipnbloiiiiaokibebpdpakdp): A keyboard interface to Chrome for mouseless browsing.
3. [Dark Reader](https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh): Dark mode for every website.
4. [AdBlock](https://chrome.google.com/webstore/detail/adblock-%E2%80%94-best-ad-blocker/gighmmpiobklfepjocnamgkkbiglidom): Block ads and pop-ups on YouTube, Facebook, Twitch, and your favorite websites.

## Set default browser

To set `chromium-browser` as the default web browser, run the following commands and choose
`chromium-browser` as alternative:

	sudo update-alternatives --config x-www-browser
	sudo update-alternatives --config gnone-www-browser

Some applications use `xdg-open`, so you also have to run the following command:
	xdg-settings set default-web-browser chromium-browser.desktop

Get more information at the debian wiki page [Default Web Browser](https://wiki.debian.org/DefaultWebBrowser).

# Install ubuntu desktop

## Download

You can download ubuntu desktop at [ubuntu download](https://ubuntu.com/#download).
All my settings have been tested with ubuntu LTS 18.04.4 desktop amd64.

## Create a bootable Ubuntu stick

In the section, I assume you are using ubuntu release >= 16.04.

1. Plug a usb device and ensure it is umounted. With the command `lsblk` you can
check if the usb device is mounted. The columns NAME and MOUNTPOINT gives us the
needed informations. If the name of the usb device is `sdb1`, to umount the usb device,
run the command:

	sudo umount /dev/sbd1

2. Now, we use the command `dd` to create the bootable stick. We still assume the name
of the usb device is `sdb1` and assume that the iso image `ubuntu-18.04.4-desktop-amd64.iso`
is in the directory `Downloads` of you user home. To create the bootable stick, run the
command:

	sudo dd bs=4M if=/home/sana/Downloads/ubuntu-18.04.4-desktop-amd64.iso \
	of=/dev/sdb1 status=progress oflag=sync

3. After a few minute, your bootable stick is created. You can unplug the usb device.

## Install ubuntu

1. Have a look on the official tutorial: [install ubuntu desktop](https://ubuntu.com/tutorials/tutorial-install-ubuntu-desktop?backURL=https://ubuntu.com/download/desktop/thank-you#1-overview).

2. It's better to be connected to the internet network to perform the installation. So stay
plug to the internet network or prepare your wifi login and password.

3. Plug your usb bootable ubuntu stick and reboot from the usb device your computer by pressing
the key *F12* when the computer restart. If it doesn't boot from the usb, don't worry, restart
the computer and press the key *F9* to choose the device to boot from. If it doesn't work try
to figure it out by restarting the computer and pressing the key *ESC* to enter in the system
information.

4. When you've entered into the installation assistant, follow the steps, they are pretty
straightforward. And if you don't get it, go back to the official installion tutorial.

# License
Project under MIT license

**Good setting for clean work. Have a better life.**
