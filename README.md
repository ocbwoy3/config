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

```bash
mkdir -p /home/ocbwoy3/Pictures/Screenshots
mkdir -p /home/ocbwoy3/Downloads
mkdir -p /home/ocbwoy3/Desktop
mkdir -p /home/ocbwoy3/Documents
mkdir -p /home/ocbwoy3/Projects
```

To avoid the same mistake of not not having internet, add Cloudflare's DNS servers to `/etc/resolv.conf`. (as root)

```
nameserver 1.1.1.1
```

Or you know, use your ISP's unsafe and possibly privacy-invasive pre-defined DNS nameservers with `networking.resolvconf.enable = true;`.
