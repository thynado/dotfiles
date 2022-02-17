.DEFAULT_GOAL:=help
SHELL:=/bin/bash

define line
	@echo "$$(tput setaf 15; tput setab 68) > $$(tput setaf 15; tput setab 8) $1 $$(tput sgr0)"
endef

.PHONY: install
install: ## Install the bits and pieces
	$(call line,Installing shell)
	@ln -vsf $$PWD/.zshrc $$HOME/.zshrc
	$(call line,Installing Homebrew)
	@if ! command -v brew &> /dev/null; then \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	$(call line,Installing Homebrew Dependencies)
	@brew bundle
	$(call line,Installing Vim)
	@ln -vsf $$PWD/.vimrc $$HOME/.vimrc
	@if [ ! -f $$HOME/.vim/autoload/plug.vim ]; then \
		curl -fLo $$HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi

.PHONY: backup
backup: ## Backup dotfiles from environment
	$(call line,Backing up Homebrew)
	@brew bundle dump -f

.PHONY: help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "Tasks:\033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-8s \033[2;99m%s\033[0m\n", $$1, $$2 }' $(MAKEFILE_LIST)