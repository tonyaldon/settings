LOG_GIT_REPOSITORIES = "/tmp/make-git-repositories.log"

.PHONY: all git_repositories

all: git_repositories

git_repositories:
	@echo "Clone submodules and set-url origin to ssh form..."
	@echo "[submodule \"i3\"]..."
	@git clone https://github.com/tonyaldon/i3.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1
	@cd i3 \
	&& git remote set-url origin git@github.com:tonyaldon/i3.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& cd ..
	@echo "[submodule \"i3\"]...done"
	@echo "[submodule \"keyboard-layout\"]..."
	@git clone https://github.com/tonyaldon/keyboard-layout.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1
	@cd keyboard-layout \
	&& git remote set-url origin git@github.com:tonyaldon/keyboard-layout.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& cd ..
	@echo "[submodule \"keyboard-layout\"]...done"
	@echo "[submodule \"uconfig\"]..."
	@git clone https://github.com/tonyaldon/uconfig.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1
	@cd uconfig \
	&& git remote set-url origin git@github.com:tonyaldon/uconfig.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& cd ..
	@echo "[submodule \"uconfig\"]...done"
	@echo "[submodule \"emacs.d/.emacs.d\"']..."
	@cd emacs.d \
	&& git clone https://github.com/tonyaldon/emacs.d.git .emacs.d\
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& cd .emacs.d \
	&& git remote set-url origin git@github.com:tonyaldon/emacs.d.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1 \
	&& cd ../..
	@echo "[submodule \"emacs.d/.emacs.d\"]...done"
	@echo "[settings] set-url origin to ssh form..."
	@git remote set-url origin git@github.com:tonyaldon/settings.git \
	> $(LOG_GIT_REPOSITORIES) 2>&1
	@echo "[settings] set-url origin to ssh form...done"
