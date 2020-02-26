LOG_GIT_REPOSITORIES = "/tmp/make-git-repositories.log"

.PHONY: all git_repositories links clean_links

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

BACKUP = .backup

links:
	@if [ ! -d $(BACKUP) ];then mkdir $(BACKUP);fi; \
	if [ -f $$HOME/.bashrc ];then mv $$HOME/.bashrc $(BACKUP)/.bashrc;fi; \
	if [ -f $$HOME/.profile ];then mv $$HOME/.profile $(BACKUP)/.profile;fi; \
	stow -t $$HOME emacs.d; \
	stow -t $$HOME uconfig; \
	stow -t $$HOME i3

clean_links:
	@stow -D -t $$HOME emacs.d; \
	stow -D -t $$HOME uconfig; \
	stow -D -t $$HOME i3; \
	if [ -f $(BACKUP)/.bashrc ];then mv $(BACKUP)/.bashrc $$HOME/.bashrc;fi; \
	if [ -f $(BACKUP)/.profile ];then mv $(BACKUP)/.profile $$HOME/.profile;fi; \
	if [ -d $(BACKUP) ]; then rm -rf $(BACKUP);fi
