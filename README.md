btw i use nix :3

1. install base nixos using the commandline

- without ui and bloat
- with this disk config

```
/dev/sda1 - 1G fat32 fmask=0022 dmask=0022 vfat
            mounts to /boot

# add compress=zstd

/dev/sdb2 - 100% btrfs
            subvol root -> /
   noatime subvol nix -> /nix
   subvol home -> /home
   subvol root -> /root
```

2. create user named 'ocbwoy3'

3. run this

```bash
cd ~
nix-shell -p git
```

4. run this inside nix shell

```bash
git clone https://github.com/ocbwoy3/config
cd config
sudo nixos-rebuild switch --flake .#default --impure --cores 4
```

5. reboot and run this

```bash
mkdir -p /home/ocbwoy3/Pictures/Screenshots
mkdir -p /home/ocbwoy3/Downloads
mkdir -p /home/ocbwoy3/Desktop
mkdir -p /home/ocbwoy3/Documents
mkdir -p /home/ocbwoy3/Projects
```

6. add to `/etc/resolv.conf` as root

```
nameserver 1.1.1.1
```

7. disable `networking.resolvconf.enable = true;` to prevent isp spying

8. install roblox
   
9. copy asset overlay content folder to `~/.var/app/org.vinegarhq.Sober/data/sober/asset_overlay`

10. done
