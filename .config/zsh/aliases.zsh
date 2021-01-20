# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias d="cd ~/dev"
alias pr="cd ~/dev/pull-requests"
alias g="git"
alias h="history"
alias j="jobs"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"
alias ll="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'


# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en10' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias ifconfig="networksetup -listallhardwareports"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

alias sha256sum="shasum -a 256"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'

# Use "highlight" in place of "cat"
#alias cat="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style solarized-light"

alias cdtmp='cd `mktemp -d /tmp/dev-XXXXXX`'
alias zconf="st $XDG_CONFIG_HOME"

alias df='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Download subtitles for all the videos in the current directory
# alias subs="docker run --rm -v '$XDG_CACHE_HOME/subliminal_cache:/usr/src/cache' -v '$(pwd):/tvshows' -it diaoulael/subliminal download -l en download /tvshows"
alias subs="subliminal --cache-dir ~/.subs download -l en download ."

alias git-delete-squashed="npx git-delete-squashed"

# suffix aliases

# starts one or multiple args as programs in background
background() {
  for ((i=2;i<=$#;i++)); do
    ${@[1]} ${@[$i]} &> /dev/null &
  done
}

alias -s html='background chromium'
alias -s {mp4,MP4,mov,MOV}='background vlc'
alias -s {zip,ZIP}="unzip -l"

if command -v hub >/dev/null 2>&1; then
	alias git="hub"
fi

alias piblet="ssh pi@piblet.local"
alias retropie="ssh pi@retropie.local"
alias osmc="ssh osmc@osmc.local"

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'

# List all contexts
alias kcgc='kubectl config get-contexts'

# usage cat log | sharecb
alias sharecb="curl -F 'file=@-' https://0x0.st"

alias restart-dm="sudo systemctl restart display-manager"

# hue
alias hue-lecture="hueadm group 1 scene=76JN1EzU2Wt9F96"
alias hue-concentration="hueadm group 1 scene=HrmDgkJsfbTAzCU"
alias hue-veilleuse="hueadm group 1 scene=JFm5nnTnlFe266Q"
alias hue-detente="hueadm group 1 scene=M1rd2aGa2qXMmCz"
