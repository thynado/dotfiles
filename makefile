.DEFAULT_GOAL:=help
SHELL:=/bin/bash

define line
	@echo "$$(tput setaf 8)> $$(tput setaf 2)$1 $$(tput sgr0)"
endef

.PHONY: install
install: ## Install Zsh, Homebrew, Vim, etc.
	$(call line,Installing shell)
	@cp .zshrc $$HOME/.zshrc
	$(call line,Installing Homebrew)
	@if ! command -v brew &> /dev/null; then \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	$(call line,Installing Homebrew Dependencies)
	@brew bundle
	$(call line,Installing Vim)
	@cp .vimrc $$HOME/.vimrc
	@if [ ! -f $$HOME/.vim/autoload/plug.vim ]; then \
		curl -fLo $$HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi

.PHONY: backup
backup: ## Backup dotfiles, configs, etc.
	$(call line,Backing up Homebrew)
	@brew bundle dump -f -q
	$(call line,Backing up VSCode)
	@cp $$HOME/Library/Application\ Support/Code/User/settings.json ./config/vscode.settings.json
	@cp $$HOME/Library/Application\ Support/Code/User/keybindings.json ./config/vscode.keybindings.json

.PHONY: help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_-]+:.*?##/ { printf "make %-8s \033[2;99m%s\033[0m\n", $$1, $$2 }' $(MAKEFILE_LIST)
