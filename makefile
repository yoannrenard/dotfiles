.DEFAULT_GOAL := help
.PHONY: install

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo ""

##
## Setup
##---------------------------------------------------------------------------

install:            ## Install env
	ln -s $(PWD)/.gitconfig ~/.gitconfig
	ln -s $(PWD)/.gitignore ~/.gitignore

	cat $(PWD)/.bashrc >> ~/.bashrc
