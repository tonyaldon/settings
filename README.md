# About
My linux [ubuntu](https://ubuntu.com/) user configuration.

This configuration works on linux ubuntu 18.04 LTS.

Meaning of the directories:
1. [emacs.d](https://github.com/tonyaldon/emacs.d) contains my
   [emacs](https://www.gnu.org/software/emacs/) configuration,
2. [i3](https://github.com/tonyaldon/i3) contains my [i3](https://i3wm.org/)
   configuration,
3. [keyboard-layout](https://github.com/tonyaldon/keyboard-layout) contains my
   keyboard layout (takbl),
4. [uconfig](https://github.com/tonyaldon/uconfig) contains other user
   configuration files.

# Motivation
1. Good management of my workspace to work efficiently.
2. Share my setting system.

# Install

My linux configuration includes:
* some classic dotfiles (.bashrc, .profile, .gitconfig,...),
* my keyboard-layout `takbl`,
* a few debian packages (stow, net-tools,...) and python packages (grip,...),
* the installation of `i3` (last release),
* and the `i3` config files (.i3status.conf, conf),
* the installation of `emacs` (last release - snapshot),
* the installation of `cask` to manage dependencies of my emacs
   configuration,
* my emacs configuration,
* a specific structure of my home directory.

You can install the whole configuration or only parts of that one. In
both cases, the `Makefile` files are worth reading.

To install just parts of that one you can browse this `README` and
the `READMEs` of the submodules.

To install the whole installation, follow the following steps:

1. Install `git`, `make`, `stow` and clone this repository:

	a. Standard Way:

		sudo apt install git make stow
		git clone --recurse-submodules https://github.com/tonyaldon/settings.git
		cd settings

	b. (for me) Also set git `remote url` to `ssh` protocol:

		sudo apt install git make stow
		cd ~/ && mkdir work && cd work
		git clone https://github.com/tonyaldon/settings.git
		cd settings
		make git_repositories

2. Install `takbl` keyboard layout and active it.  To get more
   details, see
   [keyboard-layout](https://github.com/keyboard-layout).

		cd path/to/settings/keyboard-layout
		make install

3. Install some debian pakages and python packages:

		make deb_packages
		make python_packages

4. Set the links in the `$HOME` directory:

		make links
		source .bashrc

5. (optional) Structure the `$HOME` directory:

		make home_directory

6. Install `emacs` (snapshot), `cask` and all the dependencies of my
   emacs configuration.  To get more details, see
   [emacs.d](https://github.com/emacs.d).

		cd path/to/settings/emacs.d/.emacs.d
		make install

7. Copy SSH keys into the `~/.ssh` directory.

8. Configure the laptop lid switch.

9. Install `i3` (last release) and reboot with `i3` as window
   manager. To get more details, see [i3](https://github.com/i3).

		sudo apt install i3
		reboot

10. Set chromium as default browser:

	a. To set `chromium-browser` as the default web browser, run the
    following commands and choose `chromium-browser` as alternative:

		sudo update-alternatives --config x-www-browser
		sudo update-alternatives --config gnone-www-browser

	b. Some applications use `xdg-open`, so you also have to run the
    following command:

		xdg-settings set default-web-browser chromium-browser.desktop

11. Configure chromium by adding the chrome extensions and configuring
    the Saka Key extension.

12. Enjoy programming ;)

# Home directory

You can skip this section that just describe how I structure my home directory.
It's a reminder for me.

	~/
	|__ downloads/
	|__ life/
	|__ work/
	    |__ apps/
	    |__ learning/
	    |__ mathstyle/
	    |__ medias/
	    |__ miscellaneous/
	    |__ settings/
	    |__ tmp/
	    |__ videos/
	    |__ extra.org
	    |__ notes.org

To get this tree structure, run the commands:

	git clone https://github.com/tonyaldon/settings.git
	cd settings
	make home_directory

# Setup

To grab all the dependencies, run the command:

	git clone --recurse-submodules https://github.com/tonyaldon/settings.git

Or to grab all dependencies, set remote url to ssh protocol and get submodules as
stand alone repositories, run the commands:

	git clone https://github.com/tonyaldon/settings.git
	cd settings
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
[keyboard layout](https://github.com/tonyaldon/keyboard-layout) README.

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

3. I solve the problem by `removing` the `pulse` user config file and `rebooting` the
system. Concretely, I ran the following commands:

		rm -r ~/.config/pulse
		reboot

See the [stackexchange discussion](https://askubuntu.com/questions/1056153/pulseaudio-not-working-daemon-already-running-and-no-permission-for-home-folder)
to get more information.

# Video

## Kdenlive

If you want to use `Breeze Dark` theme into `kdenlive`, `kdenlive`
should be installed and you have to install `kde-runtime` package and
enable it in section `Settings > Theme` of `kdenlive`. To do so, run
the command:

	sudo apt install kde-runtime

## Sound card drivers
I've had some trouble with the sound card drivers. To get more
information I've install the packages `vainfo` and `vdpauin`. I solve
the problem by installing the packages `mesa-vdpau-drivers`,
`libvdpau-dev`, `libvdpau-va-gl1`.

	sudo apt install mesa-vdpau-drivers libvdpau-dev libvdpau-va-gl1

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

## Chrome extensions

I'm using it with the following extensions:

1. [Saka](https://chrome.google.com/webstore/detail/saka/nbdfpcokndmapcollfpjdpjlabnibjdi): elegent tab search, selection, and beyond.
2. [Saka Key](https://chrome.google.com/webstore/detail/saka-key/hhhpdkekipnbloiiiiaokibebpdpakdp): A keyboard interface to Chrome for mouseless browsing.
3. [Dark Reader](https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh): Dark mode for every website.
4. [AdBlock](https://chrome.google.com/webstore/detail/adblock-%E2%80%94-best-ad-blocker/gighmmpiobklfepjocnamgkkbiglidom): Block ads and pop-ups on YouTube, Facebook, Twitch, and your favorite websites.

Note: I'm using a specific set of key bindings for the Saka Key
extension. See the file [takbl-saka-key](./uconfig/.takbl-saka-key).

## Set default browser

To set `chromium-browser` as the default web browser, run the following commands and choose
`chromium-browser` as alternative:

	sudo update-alternatives --config x-www-browser
	sudo update-alternatives --config gnone-www-browser

Some applications use `xdg-open`, so you also have to run the following command:

	xdg-settings set default-web-browser chromium-browser.desktop

Get more information at the debian wiki page [Default Web Browser](https://wiki.debian.org/DefaultWebBrowser).

## Chromium settings

1. Set download directory path (Advanced setting),
2. Set order language base on my preference (Advanced setting),
3. Turn off ask for notification: `Settings > Privacy and Security > Site settings > Notifications`,
4. Hide chrome extension: Click right on the extension, then choose `hide in chromium menu`,
5. Create custom Shortcuts for commands related to extensions: visit `chrome://extensions/shortcuts`,
6. Use `GTK+` theme: `Settings > Appearence > themes > GTK+`.

# Backup
## Backup

I've written `Makefile targets` that leverage
[rsync](https://rsync.samba.org/) power to handle the backup of my
directories `~/life/`, `~/work/`, `~/.ssh/`, `~/.tony/`, `/etc/` and
`~/var/www/`. For now the backups are made on two different usb
drives.

To do the backup, first I plug the usb drive that use to be on
`/dev/sdb1` and I run the commands:

	pmount /dev/sdb1 usb
	make backup_put_usb
	pumount usb

`~/work/` is my directory that changes the more often. Sometimes I
make mistakes and delete the wrong files or I make bad changes on
files that are not versioned under a `git` directory. To go back (to
the last backup), I synchronize `~/work/` and `/media/usb/work/`
directories with the Makefile target `sync_usb_work`, I check the
differences with the last backup (using `git diff` and checking the
log file `sync.log` generated by the Makefile target `sync_usb_work`),
then I keep what I want, and, finaly, I delete the temporaries
`sync.log` file and `sync` directory.

The process is detailed below:

1. To synchronize `~/work/` and `/media/usb/work/`, I plug the usb
   drive and run the commands:

		pmount /dev/sdb1 usb
		make sync_usb_work

2. This generates the `~/work/sync/` directory containing the older
   versions off the files with the same name that differs between the
   devices. Then I can use `git diff ~/work/sync/path/to/file
   ~/work/path/to/file` to check the changes made on file
   `~/work/path/to/file` and keep only what I want.

3. In the log file `~/work/sync.log`, I can check the files I've deleted
   that have been replaced with the files on the backup.

4. When I'm ok with the new state of `~/work/` directory, I can delete
   the temporaries files and directories `sync` and `sync.log` on both
   sides. To do so, I run the commands:

		make clean_sync_usb_work
		pumount usb

## /etc directory

The `/etc` directory is really important when it comes to the
configuration of your whole linux system, that inpact all the users on
your machine or on your server.

To get the most of the changes made on the system and to be able to go
back in time to a previous configuration, I use
[etckeeper](https://etckeeper.branchable.com/) to store the `/etc`
directory in a git repository.

# Miscellaneous

## Anki

I use [anki](https://apps.ankiweb.net/) to work my memory on subject I
care about. To install it you juste have to run the following command:

	sudo apt install anki

After install it, I add it these following two addons:

1. [Zoom 2.1](https://ankiweb.net/shared/info/1846592880),
2. [Night Mode](https://ankiweb.net/shared/info/1496166067).

## fzf

[fzf](https://github.com/junegunn/fzf) is installed with `brew`, see
the [Makefile](Makefile).

`fzf` comes with a standard setup that offers useful key bindings and
fuzzy completion. To add the standard setup, run the command:

	$(brew --prefix)/opt/fzf/install


# Install ubuntu desktop

## Download

You can download ubuntu desktop at [ubuntu download](https://ubuntu.com/#download).
All my settings have been tested with ubuntu LTS 18.04.4 desktop amd64.

## Create a bootable Ubuntu stick

In the section, I assume you are using ubuntu release >= 16.04.

1. Have a look on the official tutorial: [Create a bootable USB stick on ubuntu](https://ubuntu.com/tutorials/tutorial-create-a-usb-stick-on-ubuntu#1-overview).

2. Download ubuntu. It should be on the `~/Downloads` directory.

3. Plug your USB storage.

4. Launch Startup Disk Creator

5. When launched, Startup Disk Creator will look for the ISO files in
   your Downloads folder, as well as any attached USB storage it can
   write to. If the ISO file and the USB storage selected are the good
   ones, Click on `Make Startup Disk` to start the process.

6. You can know use the bootable USB stick to install ubuntu.

## Install ubuntu

1. Have a look on the official tutorial: [install ubuntu desktop](https://ubuntu.com/tutorials/tutorial-install-ubuntu-desktop?backURL=https://ubuntu.com/download/desktop/thank-you#1-overview).

2. It's better to be connected to the internet network to perform the installation. So stay
plug to the internet network or prepare your wifi login and password.

3. Plug your usb bootable ubuntu stick and reboot from the usb device your computer by pressing
the key `F12` when the computer restart. If it doesn't boot from the usb, don't worry, restart
the computer and press the key `F9` to choose the device to boot from. If it doesn't work try
to figure it out by restarting the computer and pressing the key `ESC` to enter in the system
information.

4. When you've entered into the installation assistant, follow the steps, they are pretty
straightforward. And if you don't get it, go back to the official installion tutorial.

# License
Project under MIT license

**Good setting for clean work. Have a better life.**
