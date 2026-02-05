.DEFAULT_GOAL := help

help:
	fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	echo ""
.SILENT: help

install: ## Install env
	ln -s $(PWD)/.gitconfig ~/.gitconfig
	ln -s $(PWD)/.gitignore ~/.gitignore
	ln -s $(PWD)/.git-prompt ~/.git-prompt
	cat $(PWD)/.bashrc >> ~/.bashrc
	source ~/.bashrc
	if [[ "Darwin" ==  $(shell uname) ]]; then \
		cat $(PWD)/.bash_profile >> ~/.bash_profile; \
	fi;
	# Google container-structure-test
	curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64
	chmod +x container-structure-test-linux-amd64
	sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
.PHONY:  install
.SILENT: install

install_bat: ## Install Bat (A cat(1) clone with wings.)
	wget https://github.com/sharkdp/bat/releases/download/v0.15.0/bat_0.15.0_amd64.deb
	sudo dpkg -i bat_0.15.0_amd64.deb
	echo "alias cat='bat'" >> ~/.bashrc
	rm -f bat_0.15.0_amd64.deb
	source ~/.bashrc
.PHONY:  install_bat
.SILENT: install_bat

install_fish: ## Install Fish shell configuration
	@echo "Installing Fish configuration..."
	mkdir -p ~/.config/fish/conf.d ~/.config/fish/functions
	ln -sf $(PWD)/fish/config.fish ~/.config/fish/config.fish
	ln -sf $(PWD)/fish/conf.d/00-nvm-config.fish ~/.config/fish/conf.d/00-nvm-config.fish
	ln -sf $(PWD)/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
	@echo "Installing Fisher plugin manager..."
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
	@echo "Installing nvm.fish..."
	fish -c "fisher install jorgebucaran/nvm.fish"
	@echo "Installing Node.js via nvm.fish..."
	fish -c "nvm install 22"
	@echo "Fish configuration installed! Run 'fish' to start using it."
.PHONY:  install_fish
