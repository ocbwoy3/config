# OCbwoy3's Dotfiles

**Default values you should change. There is no point hiding them as you'll find them in the code anyway:**

- User: `ocbwoy3`
- Password: `password'
- Git creds: `OCbwoy3 <ocbwoy3@ocbwoy3.dev>`

**Prerequisites:**
- NixOS
- Knowledge of the terminal

```bash
cd ~
nix run nixpkgs#git clone https://github.com/ocbwoy3/config
cd config
sudo nixos-rebuild switch --flake .#default --impure --cores 4
```