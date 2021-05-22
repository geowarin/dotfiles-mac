
system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
    source /usr/local/opt/zplug/init.zsh
else
    source /usr/share/zsh/scripts/zplug/init.zsh
fi

zplug "rupa/z", use:z.sh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"

zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh

# Press esc-esc to add sudo to the previous command
zplug "hcgraf/zsh-sudo"

# gprune [ -r | --remote | -b | --both ] <branch-name>
#zplug "Seinh/git-prune"

# visual git - Add: ga | log: glo | diff: gd...
zplug "wfxr/forgit", defer:1
zplug "MichaelAquilina/zsh-you-should-use"

zplug "greymd/docker-zsh-completion"

# kubectl fzf completions
# zplug "plugins/kubectl", from:oh-my-zsh, defer:2
# zplug "bonnefoa/kubectl-fzf", defer:3

# Prompt
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
#zplug "sindresorhus/pure"

# Syntax highlighting needs to be loaded after compinit
zplug "zsh-users/zsh-syntax-highlighting", defer:2

export ZPLUG_LOADFILE="$XDG_CONFIG_HOME/zsh/zplug.zsh"
if ! zplug check; then
    zplug install
fi

zplug load

#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=red'
