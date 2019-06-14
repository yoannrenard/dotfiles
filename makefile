.DEFAULT_GOAL := help
.PHONY: install

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo ""

##
## Setup
##---------------------------------------------------------------------------

install:          ## Install env
	ln -s $(PWD)/.gitconfig ~/.gitconfig
	ln -s $(PWD)/.gitignore ~/.gitignore
	cat $(PWD)/.bashrc >> ~/.bashrc

install_bat:      ## Install bat
	wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
	sudo dpkg -i bat_0.11.0_amd64.deb
	echo "alias cat='bat'" >> ~/.bashrc
	rm -f bat_0.11.0_amd64.deb
