lsblk

echo "Enter disk to install to: (like /dev/sda but only enter the sda part)"
read vardisk

sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features "nix-command flakes" -- --flake .#default --disk main /dev/$vardisk