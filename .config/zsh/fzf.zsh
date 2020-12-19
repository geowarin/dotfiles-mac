
system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
    FZF_PATH=/usr/local/opt/fzf
    FZF_SHELL="$FZF_PATH/shell"
else
    FZF_PATH=/usr/share/fzf
    FZF_SHELL="$FZF_PATH"
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *$FZF_PATH/bin* ]]; then
  export PATH="$PATH:$FZF_PATH/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == *$FZF_PATH/man* && -d "$FZF_PATH/man" ]]; then
  export MANPATH="$MANPATH:$FZF_PATH/man"
fi

# Auto-completion
# ---------------

[[ $- == *i* ]] && source "$FZF_SHELL/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_SHELL/key-bindings.zsh"
