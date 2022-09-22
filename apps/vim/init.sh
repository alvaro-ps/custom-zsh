basepath=$(cd $(dirname "$0") && pwd)
# hard link to the custom vimrc file
ln -f $basepath"/vimrc" ~/.vimrc
