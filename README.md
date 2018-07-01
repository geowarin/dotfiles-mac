# dotfiles

My dotfiles. I'm a java{,script} developer.

I use [yadm](https://thelocehiliosan.github.io/yadm/) to manage them. It's a wrapper around git that can encrypt files and stuff.

I've been inspired by [gverilla](https://github.com/gverilla/dotfiles) to follow the [xdg](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html)
standard in which all of the config is stored in `.config` and therefore not cluttering the home.

It requires a bit of thouroughness to follow this standard: some of the tools that I use might not be compatible by default.

The rule of thumbs is: if you find a dotfile in your home that you would prefer to keep, consult [this guide](https://wiki.archlinux.org/index.php/XDG_Base_Directory_support) and 
add the workaround to `/.config/zsh/zshenv` (often an alias or an env variable).

## Install

```
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
YADM_HOME="$XDG_CONFIG_HOME/yadm"
YADM_DATA="$XDG_DATA_HOME/yadm"
yadm -Y $YADM_HOME --yadm-repo $YADM_DATA/repo.git clone https://github.com/gverilla/dotfiles
```

This will prompt you to run the [boostrap file](https://github.com/geowarin/dotfiles/blob/master/.config/yadm/bootstrap).

## Bootstrap

Bootstrap installs brew and executes the Brewfile.
It will then setup your default shell to be zsh.

## Zsh

I use [zplug](https://github.com/zplug/zplug) to manage zsh plugins.
See [.config/zsh/plugins.zsh](https://github.com/geowarin/dotfiles/blob/master/.config/zsh/plugins.zsh) for the list.

## Making changes

When you modify the files that are versionned, use `yadm add`, `yadm commit` and `yadm push` (if you forked the repo).

I suggest that you only commit the `.config` files, that will keep everything clean.
