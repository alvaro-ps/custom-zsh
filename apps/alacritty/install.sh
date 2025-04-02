brew install --cask alacritty --no-quarantine
mkdir -p ~/.config/alacritty

# See https://github.com/catppuccin/alacritty/tree/main
curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
