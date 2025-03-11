{ inputs, config, pkgs, ... }:

{

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		monaspace
		geist-font
		# nerdfonts
		nerd-fonts.geist-mono
		nerd-fonts.monaspace
		nerd-fonts.symbols-only
	];

	programs.seahorse.enable = true;

	environment.variables.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";

	environment.systemPackages = with pkgs; [
		inputs.hyprsysteminfo.packages.${pkgs.stdenv.hostPlatform.system}.hyprsysteminfo
		# minecraft
		qemu
		(writeShellScriptBin "qemu-system-x86_64-uefi" ''
			qemu-system-x86_64 \
				-bios ${OVMF.fd}/FV/OVMF.fd \
				"$@"
		'')
		(writeShellScriptBin "regretevator" ''xdg-open roblox://placeId=4972273297'')
		libxkbcommon
		ffmpeg
		gnupg
		nix-direnv
		htop
		nixpkgs-fmt
		nixd
		catppuccin-cursors.mochaBlue
		kitty
		unzip
		libwebp
		ifuse
		w3m
		imagemagick
		alacritty
		libimobiledevice
		vim
		direnv
		nautilus
		kdePackages.dolphin
		kdePackages.kservice
		qpwgraph
		wget
		git
		fastfetch
		vscode
		nodejs
		bun
		yarn
		(python3.withPackages (subpkgs: with subpkgs; [
			requests
			pypresence
			pygobject3
		]))
		# wrangler
		thefuck
		fontforge
		xclip
		gamescope
		yt-dlp
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
		libsForQt5.polkit-kde-agent
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
		nixfmt-rfc-style
	];

}
