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
	]

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
		};
		{
			name = "sober";
			location = "https://sober.vinegarhq.org/repo/"
		}
	];

	services.flatpak.packages = [
		{ appId = "org.vinegarhq.Sober"; origin = "sober";  }
	];

	programs.hyprland = {
		# Install the packages from nixpkgs
		enable = true;
		# Whether to enable XWayland
		xwayland.enable = true;
	};

	main-user.userName = "ocbwoy3";
	main-user.realName = "OCbwoy3";
	main-user.packages = with pkgs; [
		brave
		prismlauncher
		vesktop
	];

	catppuccin.enable = true;
	catppuccin.flavor = "mocha";

}
