export ZPLUG_HOME=/usr/local/opt/zplug

source $ZPLUG_HOME/init.zsh
 
# zgen oh-my-zsh plugins/github
# zgen oh-my-zsh plugins/sudo
# zgen oh-my-zsh plugins/command-not-found
# zgen oh-my-zsh plugins/sublime
# zgen oh-my-zsh plugins/npm
# zgen oh-my-zsh themes/wedisagree

zplug "rupa/z", use:z.sh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"

zplug "lib/key-bindings", from:oh-my-zsh
zplug "plugins/sublime", from:oh-my-zsh

zplug "hcgraf/zsh-sudo"
zplug "Seinh/git-prune"
zplug 'wfxr/forgit', defer:1
zplug "MichaelAquilina/zsh-you-should-use"

# Prompt
zplug "sindresorhus/pure"

# Syntax highlighting needs to be loaded after compinit
zplug "zsh-users/zsh-syntax-highlighting", defer:2

export ZPLUG_LOADFILE="$XDG_CONFIG_HOME/zsh/zplug.zsh"
if ! zplug check; then
    zplug install
fi

zplug load