git clone --bare https://github.com/geowarin/dotfiles.git $HOME/dotfiles
function dotfiles {
   /usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME $@
}
function back {
    mkdir -p $(dirname "$2")
    mv $1 $2
}

dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out dotfiles."
else
    echo "Backing up pre-existing dotfiles."
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} \
        | xargs -I{} bash -c 'mkdir -p ".dotfiles-backup/{}" && mv "{}" ".dotfiles-backup/{}"'
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no
