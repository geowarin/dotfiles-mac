# dotfiles

My dotfiles. I'm a java{,script} developer.

https://www.atlassian.com/git/tutorials/dotfiles


I've been inspired by [gverilla](https://github.com/gverilla/dotfiles) to follow the [xdg](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html)
standard in which all of the config is stored in `.config` and therefore not cluttering the home.

It requires a bit of thouroughness to follow this standard: some of the tools that I use might not be compatible by default.

The rule of thumbs is: if you find a dotfile in your home that you would prefer to keep, consult [this guide](https://wiki.archlinux.org/index.php/XDG_Base_Directory_support) and 
add the workaround to `/.config/zsh/zshenv` (often an alias or an env variable).

## Install

```
curl -Lks https://raw.githubusercontent.com/geowarin/dotfiles/master/.bin/install.sh | /bin/bash
```

## Zsh

I use [zplug](https://github.com/zplug/zplug) to manage zsh plugins.
See [.config/zsh/plugins.zsh](https://github.com/geowarin/dotfiles/blob/master/.config/zsh/plugins.zsh) for the list.

## Making changes

When you modify the files that are versionned, use `yadm add`, `yadm commit` and `yadm push` (if you forked the repo).

I suggest that you only commit the `.config` files, that will keep everything clean.
