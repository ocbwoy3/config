lsblk

echo "Enter disk to install to: "
read vardisk

sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features "nix-command flakes" -- --flake .#default --disk $vardisk