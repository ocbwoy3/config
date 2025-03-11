lsblk

printf "Installing OCbwoy3's Dotfiles\nSit back and wait until NixOS (and the config) gets installed, or do something in the meantime.\n\n"

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount hosts/default/disko.nix
sudo nixos-install --flake .#default

# sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features "nix-command flakes" -- --flake .#default --disk main /dev/$vardisk