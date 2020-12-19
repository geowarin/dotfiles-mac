git clone --bare git@github.com:geowarin/dotfiles.git $HOME/dotfiles
function dotfiles {
   /usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME $@
}
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    mkdir -p .dotfiles-backup
    echo "Backing up pre-existing dotfiles.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no
