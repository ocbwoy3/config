lsblk

printf "\n\nWelcome to OCbwoy3's Dotfiles!!\n\nThis will be semi-automatic until the install phase. Now, let's wipe all your disks and partition them.\n\n"

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount hosts/default/disko.nix

printf "\n\nInstalling NixOS, plz something in the meantime.\n\n"

sudo nixos-install --flake .#default

# sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features "nix-command flakes" -- --flake .#default --disk main /dev/$vardisk