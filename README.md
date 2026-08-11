### .dotfiles

This is OUR linux config

please run all bash scripts to set up. (running `make` in ~/.dotfiles should do this)

home-fs simulates the $HOME directory, so all config files found in the home directory should have an equivalent path, with home_fs/ instead of $HOME
 - e.g. ~/.config/i3/config would instead be home_fs/.config/i3/config

please only edit .dotfiles in this directory, as any changes to the .dotfiles in the actual filesystem will not be recorded to this repo

use bfs
