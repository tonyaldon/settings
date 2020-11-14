LOG_GIT_REPOSITORIES = "/tmp/make-git-repositories.log"

.PHONY: all git_repositories links clean_links default_directories \
        home_directory clean_default_directories clean_home_directory \
	sync_usb_get_work sync_usb_put_work sync_usb_work

all: git_repositories links

define clone_submodule
	$(if $(filter $(1),emacs.d),@echo "[submodule \"$(1)/$(2)\"]"...,\
	  @echo "[submodule \"$(1)\"]"...); \
	cd $(3); \
	git clone https://github.com/tonyaldon/$(1).git $(2)\
	  > $(LOG_GIT_REPOSITORIES) 2>&1; \
	cd $(2); \
	git remote set-url origin git@github.com:tonyaldon/$(1).git \
	  > $(LOG_GIT_REPOSITORIES) 2>&1; \
	$(if $(filter $(1),emacs.d),cd ../..,cd ..); \
	echo "[submodule \"$(1)\"]...done"
endef

git_repositories:
	@echo "Clone submodules and set-url origin to ssh form..."
	$(call clone_submodule,i3,i3,.)
	$(call clone_submodule,keyboard-layout,keyboard-layout,.)
	$(call clone_submodule,uconfig,uconfig,.)
	$(call clone_submodule,emacs.d,.emacs.d,emacs.d)
	@echo "[settings] set-url origin to ssh form..."
	@git remote set-url origin git@github.com:tonyaldon/settings.git \
	  > $(LOG_GIT_REPOSITORIES) 2>&1
	@echo "[settings] set-url origin to ssh form...done"
	@git submodule init
	@echo "Clone submodules and set-url origin to ssh form...done"

BACKUP_DOT_FILES = .backup

links:
	@if [ ! -d $(BACKUP_DOT_FILES) ];then mkdir $(BACKUP_DOT_FILES);fi; \
	if [ -f $$HOME/.bashrc ];then mv $$HOME/.bashrc $(BACKUP_DOT_FILES)/.bashrc;fi; \
	if [ -f $$HOME/.profile ];then mv $$HOME/.profile $(BACKUP_DOT_FILES)/.profile;fi; \
	stow -t $$HOME emacs.d; \
	stow -t $$HOME uconfig; \
	stow --ignore=Makefile -t $$HOME i3; \
	if [ -d /usr/share/themes/Emacs ];then mv /usr/share/themes/Emacs \
	  $(BACKUP_DOT_FILES);fi; \
	sudo stow -t / root/

clean_links:
	@stow -D -t $$HOME emacs.d; \
	stow -D -t $$HOME uconfig; \
	stow -D -t $$HOME i3; \
	sudo stow -D -t / root/; \
	if [ -f $(BACKUP_DOT_FILES)/.bashrc ];then mv $(BACKUP_DOT_FILES)/.bashrc $$HOME/.bashrc;fi; \
	if [ -f $(BACKUP_DOT_FILES)/.profile ];then mv $(BACKUP_DOT_FILES)/.profile $$HOME/.profile;fi; \
	if [ -d $(BACKUP_DOT_FILES)/Emacs ];then \
	  sudo mv $(BACKUP_DOT_FILES)/Emacs /usr/share/themes/ ;fi; \
	if [ -d $(BACKUP_DOT_FILES) ]; then rm -rf $(BACKUP_DOT_FILES);fi

DEFAULT_DIRECTORIES = Desktop Documents Downloads Music Pictures Public Templates Videos
HOME_DIRECTORY = \
    downloads \
    life \
    work/apps \
    work/learning \
    work/mathstyle \
    work/medias \
    work/miscellaneous \
    work/settings \
    work/tmp/ \
    work/videos

default_directories:
	@for dir in $(DEFAULT_DIRECTORIES); do \
	    mkdir -p $$HOME/$$dir; \
	done

home_directory: clean_default_directories
	@for dir in $(HOME_DIRECTORY); do \
	  mkdir -p $$HOME/$$dir; \
	done

clean_default_directories:
	@for dir in $(DEFAULT_DIRECTORIES); do \
	  if [ -d $$HOME/$$dir ]; then \
	    if [ -z "$$(ls -A $$HOME/$$dir)" ]; then \
	      rm -rf $$HOME/$$dir; \
	    else \
	      echo "$$HOME/$$dir: can't remove: not empty directory"; \
	    fi; \
	  fi; \
	done

clean_home_directory:
	@for dir in $(HOME_DIRECTORY); do \
	  if [ -d $$HOME/$$dir ]; then \
	    if [ -z "$$(ls -A $$HOME/$$dir)" ]; then \
	      rm -rf $$HOME/$$dir; \
	    else \
	      echo "$$HOME/$$dir: can't remove: not empty directory"; \
	    fi; \
	  fi; \
	done

deb_packages_minimal:
	@sudo apt install \
	  git \
	  stow \
	  make \
	  tree \
	  feh \
	  xbindkeys \
	  net-tools \
	  curl \
	  chromium-browser \
	  openssh-server \
	  sshfs \
	  xvkbd \
	  whois \
	  etckeeper \
	  gawk \
	  pmount \
	  libimobiledevice6 \
	  libimobiledevice-utils \
	  ifuse \
	  gcc \
	  g++ \
	  php \
	  ncftp \
	  nginx \
	  certbot \
	  libgtk-3-dev \
	  gtk-theme-switch \
	  htop \
	  inotify-tools \
	  wmctrl \
	  xdotool \
	  libreoffice

deb_packages_python:
	@sudo apt install \
	  python-minimal \
	  python3-pip \
	  python3-venv

deb_packages_node:
	@curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - ; \
	sudo apt install nodejs

deb_packages_medias:
	@sudo apt install \
	  vlc \
	  mediainfo \
	  ffmpeg \
	  imagemagick \
	  kdenlive \
	  kde-runtime \
	  blender \
	  inkscape \
	  gimp \
	  audacity

deb_packages_learning:
	@sudo apt install \
	  klavaro \
	  anki

deb_packages: deb_packages_minimal \
	      deb_packages_python \
	      deb_packages_node \
	      deb_packages_medias \
	      deb_packages_learning

python_packages:
	@pip3 install grip

node_packages:
	@sudo npm i -g pm2 ; \
	sudo npm i -g tern

media_packages:
	@sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl \
	  -o /usr/local/bin/youtube-dl ; \
	sudo chmod a+rx /usr/local/bin/youtube-dl

brew_install:
	@/bin/bash -c "$$(curl -fsSL \
	  https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew_packages:
	@brew install watchman ; \
	brew install cloc ; \
	brew install fzf

USB = /media/usb
BACKUP_USB_LOG = $(USB)/backup.log

define rsync_avz_exclude
	printf "\n\n[%s --> %s]\n" "$(1)" "$(USB)/$(2)/" \
	  | tee -a $(BACKUP_USB_LOG) ; \
	rsync -avz --exclude="*node_modules*" --delete-excluded \
	  $(1) $(USB)/$(2)/ | tee -a $(BACKUP_USB_LOG)
endef

define rsync_avz_delete
	printf "\n\n[%s --> %s]\n" "$(1)" "$(USB)/$(2)/" \
	  | tee -a $(BACKUP_USB_LOG) ; \
	$(3) rsync -avz --delete \
	  $(1) $(USB)/$(2)/ | tee -a $(BACKUP_USB_LOG)
endef

backup_put_usb:
	@printf "\n\n\n%s\n" "[backup date] `date +'%F %T %Z'`" \
	  >> $(BACKUP_USB_LOG) ; \
	$(call rsync_avz_exclude,$$HOME/life/,life) ; \
	$(call rsync_avz_exclude,$$HOME/work/,work) ; \
	$(call rsync_avz_delete,$$HOME/.ssh/,ssh,) ; \
	$(call rsync_avz_delete,$$HOME/.tony/,tony,) ; \
	$(call rsync_avz_delete,/etc/,etc-tony,sudo) ; \
	$(call rsync_avz_exclude,/var/www,var-tony)

SYNC = sync
SYNC_WORK_LOG = $(USB)/sync.log

define rsync_auvzb_exclude
	printf "\n\n[%s --> %s]\n" "$(1)" "$(2)" \
	  | tee -a $(SYNC_WORK_LOG) ; \
	rsync -auvzb --backup-dir="$(SYNC)" --exclude="*node_modules*" \
	  $(1) $(2) | tee -a $(SYNC_WORK_LOG)
endef

sync_usb_work:
	@printf "%s\n" "[sync work directory date] `date +'%F %T %Z'`" \
	  >> $(SYNC_WORK_LOG) ; \
	$(call rsync_auvzb_exclude,$(USB)/work/,$$HOME/work/) ; \
	$(call rsync_auvzb_exclude,$$HOME/work/,$(USB)/work/) ; \
	$(call rsync_auvzb_exclude,$(USB)/work/,$$HOME/work/) ; \
	cp $(SYNC_WORK_LOG) $(USB)/work/ ; \
	mv $(SYNC_WORK_LOG) $$HOME/work/

clean_sync_usb_work:
	@rm -r $$HOME/work/$(SYNC) $$HOME/work/sync.log ; \
	rm -r $(USB)/work/$(SYNC) $(USB)/work/sync.log
