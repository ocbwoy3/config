{ config, pkgs, ... }:

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

	# Sadly, I don't know how to install flatpaks like this.
	services.flatpak.packages = [
		# "com.usebottles.bottles"
		# { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "0"; }
	];

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
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
	};

	main-user.packages = with pkgs; [
		warp-terminal
		prismlauncher
		vesktop
		kdenlive
		libsForQt5.qt5ct
		libsForQt5.lightly
		kdePackages.qt6ct
		lightly-qt
		# (pkgs.callPackage ./apps/crossover.nix {})
	];

	# CHANGE YOUR NAME IN HOME MANAGER!

	main-user.userName = "ocbwoy3";
	main-user.realName = "OCbwoy3";

	catppuccin = {
		enable = true;
		flavor = "mocha";
		accent = "blue";
	};

	home-manager.users.ocbwoy3 = {

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
