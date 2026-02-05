# Dotfiles

## How to install

```bash
$ git clone git@github.com:yoannrenard/dotfiles.git
$ cd dotfiles
$ make install
```

### Install bat

```bash
$ make install_bat
```

### Install Fish shell

Requires [Fish shell](https://fishshell.com/) to be installed first:

```bash
# macOS
$ brew install fish

# Ubuntu/Debian
$ sudo apt install fish
```

Then install the configuration:

```bash
$ make install_fish
```

This will:
- Symlink Fish config files
- Install [Fisher](https://github.com/jorgebucaran/fisher) (plugin manager)
- Install [nvm.fish](https://github.com/jorgebucaran/nvm.fish) (Node version manager)
- Install Node.js v22

To set Fish as your default shell:

```bash
$ echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells  # macOS
$ chsh -s /opt/homebrew/bin/fish
```
