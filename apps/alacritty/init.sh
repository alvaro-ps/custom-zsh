basepath=$(cd $(dirname "$0") && pwd)
# hard link to the custom vimrc file
ln -f "${basepath}/alacritty.toml" ~/.config/alacritty/alacritty.toml
ln -f "${basepath}/catppuccin-mocha.toml" ~/.config/alacritty/catppuccin-mocha.toml
