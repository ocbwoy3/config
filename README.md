# OCbwoy3's Dotfiles

**Prerequisites:**

- NixOS
- Knowledge of the terminal

# How to install

step 1. install base nixos using the commandline (without ui and bloat) with this disk config (assuming it's /dev/sda)

```
/dev/sda1 - 1G fat32 fmask=0022 dmask=0022 vfat
            mounts to /boot

# optionally add compress=zstd (which i forgot to do)

/dev/sdb2 - 100% btrfs
            subvol root -> /
   noatime subvol nix -> /nix
   subvol home -> /home
   subvol root -> /root
```

step 2. create user named 'ocbwoy3'

step 3. 

```bash
cd ~
nix-shell -p git
```

once you're in the shell

```bash
git clone https://github.com/ocbwoy3/config
cd config
sudo nixos-rebuild switch --flake .#default --impure --cores 4
```
