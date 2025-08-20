{ config, pkgs, ... }:

{
	imports = [
		./nixos/bootloader.nix
		./nixos/hardware.nix
		./nixos/i18n.nix
		./nixos/network.nix
		./nixos/nixpkgs.nix
		./nixos/nvidia.nix
		./nixos/programs.nix
		./stuff/nvim.nix
		./stuff/zsh.nix
	];

	environment.systemPackages = with pkgs; [
		tmux
		gh
		file
		glib
		openssl
		nss
		glibc
		nixfmt-rfc-style
		killall
		deno
		bun
		imagemagick
		unzip
		libwebp
		nix-direnv
		htop
		nixpkgs-fmt
		nixd
		ffmpeg-full
		gnupg
	];
}
