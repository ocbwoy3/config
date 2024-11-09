# OCbwoy3's Dotfiles
The second ones, because the first ones were too difficult to install.

```bash
cd ~
nix-shell -p git --run "git clone https://github.com/ocbwoy3/config"
cd config
cp /etc/nixos/hardware-configuration.nix .
sudo nixos-rebuild switch --flake ./#default --impure
```

Commands you will most likely need:
```bash
sudo nixos-rebuild switch --flake ./#default --impure
```
