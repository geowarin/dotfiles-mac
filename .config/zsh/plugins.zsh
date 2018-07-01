export ZPLUG_HOME=/usr/local/opt/zplug

source $ZPLUG_HOME/init.zsh
 
zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

zplug "zsh-users/zsh-history-substring-search"
# Syntax highlighting needs to be loaded after compinit
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "sindresorhus/pure"

zplug "zsh-users/zsh-syntax-highlighting"

export ZPLUG_LOADFILE="$XDG_CONFIG_HOME/zsh/zplug.zsh"
if ! zplug check --verbose; then
    zplug install
fi

zplug load