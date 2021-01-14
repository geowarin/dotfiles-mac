# dotfiles

My dotfiles. I'm a java{,script} developer.

I use the "bare repository and alias method" described here:

https://wiki.archlinux.org/index.php/Dotfiles

https://www.atlassian.com/git/tutorials/dotfiles

## Compatibility: Arch & Macos

I used macos when I first compiled my dotfiles.

I've now switched to arch (endeavourOs). 

The install process should be compatible with both systems.

## Install

```
curl -Lks https://raw.githubusercontent.com/geowarin/dotfiles/master/.bin/install.sh | /bin/bash
```

Then you might want to run `.bin/boostrap.sh` to install the necessay dependecies with brew (macos) or pamac (manjaro).

## Zsh

I use [zplug](https://github.com/zplug/zplug) to manage zsh plugins.
See [.config/zsh/plugins.zsh](https://github.com/geowarin/dotfiles/blob/master/.config/zsh/plugins.zsh) for the list.

## Making changes

When you modify files that are not versionned, from your home directory, use `df add .config/my/file`, `df commit` and `df push`.
Otherwise simply `df add -u` to add all the modified files to staging.
