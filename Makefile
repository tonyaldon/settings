LOG_GIT_REPOSITORIES = "/tmp/make-git-repositories.log"

.PHONY: all git_repositories

all: git_repositories

define clone_submodule
	$(if $(filter $(1),emacs.d),@echo "[submodule \"$(1)/$(2)\"]"...,\
	@echo "[submodule \"$(1)\"]"...)
	@cd $(3) \
	&& git clone https://github.com/tonyaldon/$(1).git $(2)\
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& cd $(2) \
	&& git remote set-url origin git@github.com:tonyaldon/$(1).git \
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& $(if $(filter $(1),emacs.d),cd ../..,cd ..)
	@echo "[submodule \"$(1)\"]...done"
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
