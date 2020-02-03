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

# setup

To grab all the dependencies:

	git clone --recurse-submodules https://github.com/tonyaldon/settings.git

# Installation

To make appropriate symbolinc links for `i3`, `.emacs.d` and
`uconfig`, run following commands:

	cd settings
	chmod +x install.sh
	./install.sh

Symbolic links are done with [stow](https://www.gnu.org/software/stow/).

To install `takbl` keyboard layout, see 
[keyboard layout](https://github.com/tonyaldon/keyboard-layout/tree/c3b2c099c2f3123e14c8488d0b7c02ebb0f52990) README.

# License
Project under MIT license

**Good setting for clean work. Have a better life.**
