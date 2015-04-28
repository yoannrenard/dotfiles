# vars
pathToMe = /home/yoann/workspace/work-config/

install:
	ln -s $(pathToMe).gitconfig      ~/.gitconfig
	ln -s $(pathToMe).gitignore      ~/.gitignore

	cat $(pathToMe).bashrc >> ~/.bashrc
