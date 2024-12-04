{ config, pkgs, ... }:

{

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		monaspace
		nerdfonts
		# nerd-fonts.monaspace
	];

	environment.systemPackages = with pkgs; [
		nix-direnv
		unzip
		ifuse
		w3m
		imagemagick
		alacritty
		libimobiledevice
		vim
		microsoft-edge
		direnv
		nautilus
		kdePackages.dolphin
		kdePackages.kservice
		qpwgraph
		wget
		git
		neofetch
		vscode
		nodejs
		bun
		(python3.withPackages (subpkgs: with subpkgs; [
			requests
			pypresence
		]))
		wrangler
		thefuck
		fontforge
		xclip
		fontforge-gtk
		deno
		wofi
		waybar
		dunst
		hyprlock
		swww
		swappy
		slurp
		grim
		wl-clipboard
		github-cli
		cliphist
		pywal
		pavucontrol
		polkit
		polkit-kde-agent
		wlogout
		libnotify
		killall
		networkmanagerapplet
		blueman
		arrpc
		playerctl
		obs-studio
		mangohud
		jq
		github-cli
		file
		nwg-look
		rhythmbox
		hyprpolkitagent

		catppuccin-cursors.mochaLavender

		# important
		glib
		openssl
		nss
		glibc # C LIBRARY DO NOT REMOVE VERY IMPORTANT
		gobject-introspection 
		gimp
		mpv
	];

}
