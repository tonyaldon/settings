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
