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
		
		(writeShellScriptBin "fix-gtk" ''${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch exec "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk -r"'')
		(callPackage ./apps/wl-shimeji.nix {})
		(writeShellScriptBin "stop-shimejis" ''${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/hyprctl dispatch exec "shimejictl stop"'')
		# (writeShellScriptBin "partynoob" ''shimejictl summon PartyNoob'')
		catppuccin-gtk
		catppuccin
		catppuccin-qt5ct
		catppuccin-catwalk
		catppuccin-whiskers
		libxkbcommon
		ffmpeg-full
		gnupg
		nix-direnv
		htop
		nixpkgs-fmt
		nixd
		catppuccin-cursors.mochaBlue
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
		hyprpaper
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
		mangohud
		jq
		github-cli
		file
		nwg-look
		rhythmbox
		hyprpolkitagent

		# important
		glib
		openssl
		nss
		glibc # C LIBRARY DO NOT REMOVE VERY IMPORTANT
		gobject-introspection 
		gimp
		mpv
		nixfmt-rfc-style

		protonvpn-cli
		protonvpn-gui
		(writeShellScriptBin "protonvpn" ''${pkgs.protonvpn-cli}/bin/protonvpn-cli "$@"'')

		(writeShellScriptBin "roblox-studio-patcher" ''${pkgs.bun}/bin/bun run /home/ocbwoy3/config/scripts/bin/patchInternalRobloxStudio.ts'')

	];

}
