{ config, inputs, pkgs, ... }:

{

	imports = [
		../../modules/nixos/nixpkgs.nix
		../../modules/nixos/bootloader.nix
		../../modules/nixos/hardware.nix
		../../modules/nixos/nvidia.nix
		../../modules/nixos/i18n.nix
		../../modules/nixos/main-user.nix
		../../modules/nixos/network.nix
		../../modules/nixos/programs.nix
		./packages.nix
		# ../../modules/home-manager/hyprpanel.nix
		./other/activate.nix
		
	];

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};

	services.flatpak.enable = true;
	services.flatpak.remotes = [
		{
			name = "flathub";
			location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
		}
	];

	services.printing = {
		enable = true;
		drivers = with pkgs; [
			gutenprint
			gutenprintBin
			splix
			hplip
		];
		webInterface = true;
		listenAddresses = [ "*:631" ];
		allowFrom = [ "all" ];
		browsing = true;
		defaultShared = true;
		openFirewall = true;
	};

	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
		publish = {
 			enable = true;
 			userServices = true;
		};
	};

	# Sadly, I don't know how to install flatpaks like this.
	services.flatpak.packages = [
		# "com.usebottles.bottles"
		# { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "0"; }
	];

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		zsh-autoenv.enable = true;
		syntaxHighlighting.enable = true;
		ohMyZsh = {
			enable = true;
			plugins = [ "git" "direnv" "thefuck" ];
			theme = "robbyrussell";
		};
		shellAliases = {
			nixos_rebuild = "sudo nixos-rebuild switch --flake .#default --impure --cores 4";
			neofetch = "hyfetch";
		};
	};

	virtualisation.docker.enable = true;

	main-user.packages = with pkgs; [
		warp-terminal
		prismlauncher
		# vesktop
		# legcord
		equibop
		kdenlive
		libsForQt5.qt5ct
		libsForQt5.lightly
		kdePackages.qt6ct
		lightly-qt
		hyfetch
		kitty
		inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty
		(callPackage ./apps/tuxstrap-crontab.nix {})
		(callPackage ./apps/wl-shimeji.nix {})
	];

	xdg.terminal-exec.enable = true;
    xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gnome
			pkgs.xdg-desktop-portal-gtk
		];
	};
	environment.variables.XDG_TERMINAL = "${inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty}/bin/ghostty";
    environment.variables.XDG_SYSTEM_MONITOR = "${pkgs.htop}/bin/htop";

	fileSystems = {
		"/".options = [ "compress=zstd" ];
		"/home".options = [ "compress=zstd" ];
		"/nix".options = [ "compress=zstd" "noatime" ];
		"/swap".options = [ "noatime" ];
	};

	swapDevices = [ { device = "/swap/swapfile"; } ];

	services.btrfs.autoScrub = {
		enable = true;
		interval = "monthly";
		fileSystems = [ "/" ];
	};

	# CHANGE YOUR NAME IN HOME MANAGER!

	main-user.userName = "ocbwoy3";
	main-user.realName = "OCbwoy3";

	programs.dconf.enable = true;
	services.gvfs.enable = true;

	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "blue";
		# gtk.enable = true;
	};

	# home-manager.services.mpris-proxy.enable = true;

	home-manager.users.ocbwoy3 = {

		services.mpris-proxy.enable = true;

		programs.chromium = {
			enable = true;
			package = pkgs.brave;
			extensions = [
				{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
				{ id = "enamippconapkdmgfgjchkhakpfinmaj"; } # DeArrow
				{ id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Sytlus
				{ id = "hnmpcagpplmpfojmgmnngilcnanddlhb"; } # Windscribe
				{ id = "hfjngafpndganmdggnapblamgbfjhnof"; } # RoSeal
				{ id = "aflpfginfpjhanhkmdpohpggpolfopmb"; } # SkyLink
				{ id = "agjnjboanicjcpenljmaaigopkgdnihi"; } # PreMiD
				{ id = "ijcpiojgefnkmcadacmacogglhjdjphj"; } # Shinigami Eyes		
			];
		};

		programs.git = {
			enable = true;
			userName  = "OCbwoy3";
			userEmail = "ocbwoy3@ocbwoy3.dev";
		};

		home.stateVersion = "24.11";

	};

}
