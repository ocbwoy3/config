btw i use nix :3

![](etc/rice.png)

# How to use Hyprland

I choose the keybinds, you don't.

| Keybind   | What it does         |
|-----------|----------------------|
| `SUPER+Q` | Terminal             |
| `SUPER+C` | Close current window |
| `SUPER+E` | File Manager         |
| `SUPER+V` | Toggle Floating      |
| `SUPER+Q` | Terminal             |
| `SUPER+T` | App Launcher         |
| `SUPER+P` | Psuedo               |
| `SUPER+J` | Toggle Split         |
| `SUPER+F` | Fullscreen           |

| Keybind            | What it does       |
|--------------------|--------------------|
| `SUPER+RightArrow` | Move Focus (right) |
| `SUPER+LeftArrow`  | Move Focus (left)  |
| `SUPER+DownArrow`  | Move Focus (down)  |
| `SUPER+UpArrow`    | Move Focus (up)    |

| Keybind                  | What it does         |
|--------------------------|----------------------|
| `SUPER+SHIFT+RightArrow` | Window width +100    |
| `SUPER+SHIFT+LeftArrow`  | Window width -100    |
| `SUPER+SHIFT+DownArrow`  | Window height +100   |
| `SUPER+SHIFT+UpArrow`    | Window height -100   |

| Keybind                 | What it does            |
|-------------------------|-------------------------|
| `SUPER+CTRL+RightArrow` | Swap window pos (right) |
| `SUPER+CTRL+LeftArrow`  | Swap window pos (left)  |
| `SUPER+CTRL+UpArrow`    | Swap window pos (down)  |
| `SUPER+CTRL+DownArrow`  | Swap window pos (up)    |

| Mouse Keybind      | What it does   |
|--------------------|----------------|
| `SUPER+MouseLeft`  | Move window    |
| `SUPER+MouseRight` | Resize window  |
| `SUPER+ScrollUp`   | Next workspace |
| `SUPER+ScrollDown` | Prev workspace |

| Keybind             | What it does                             |
|---------------------|------------------------------------------|
| `SUPER+[0-9]`       | Switch to workspace X                    |
| `SUPER+SHIFT+[0-9]` | Move active window to workspace X        |
| `SUPER+Z`           | Special workspace                        |
| `SUPER+SHIFT+Z`     | Move current window to special Workspace |

| Keybind         | What it does                             |
|-----------------|------------------------------------------|
| `SUPER+SHIFT+B` | Reload Waybar                            |
| `CTRL+ALT+DEL`  | WLogout                                  |
| `FN+F5`         | Prev music track                         |
| `FN+F6`         | Next music track                         |
| `FN+F7`         | Play/Pause music                         |

| Keybind             | What it does                                                                                                     |
|---------------------|------------------------------------------------------------------------------------------------------------------|
| `SUPER+SHIFT+ENTER` | Change wallpaper                                                                                                 |
| `SUPER+F1`          | Hide waybar                                                                                                      |
| `SUPER+F2`          | [Roblox](https://roblox.com) [Roblox](https://sober.vinegarhq.org) [Roblox](https://github.com/ocbwoy3/tuxstrap) |
| `SUPER+Space`       | Switch Keyboard Layout (English, Latvian)                                                                        |

## How to install NixOS

1. Install base NixOS from the commandline

- Without UI and bloatware
- Use this disk configuration

```
/dev/sda1 - 1G fat32 fmask=0022 dmask=0022 vfat
            mounts to /boot

# add compress=zstd

/dev/sdb2 - 100% btrfs, with these subvolumes:
                        root -> /
              [noatime] nix -> /nix
                        home -> /home
                        root -> /root
```

2. Create user named 'ocbwoy3'

3. Run this in order:

```bash
cd ~
nix-shell -p git
```

4. Run this inside the `nix-shell`

```bash
git clone https://github.com/ocbwoy3/config
cd config
sudo nixos-rebuild switch --flake .#default --impure --cores 4
```

1. Reboot, run this in your terminal:

```bash
mkdir -p /home/ocbwoy3/Pictures/Screenshots
mkdir -p /home/ocbwoy3/Downloads
mkdir -p /home/ocbwoy3/Desktop
mkdir -p /home/ocbwoy3/Documents
mkdir -p /home/ocbwoy3/Projects
```

6. Add this to `/etc/resolv.conf` as root

```
nameserver 1.1.1.1
```

7. Install [Roblox](https://flathub.org/apps/org.vinegarhq.Sober)

8. `flatpak run org.vinegarhq.Sober`, log into your Roblox account.

9. Copy asset overlay content folder to `~/.var/app/org.vinegarhq.Sober/data/sober/asset_overlay`

10. You successfully installed it!
