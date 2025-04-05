{
	description = "OCbwoy3's Dotfiles";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		catppuccin.url = "github:catppuccin/nix";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
		hyprland.url = "github:hyprwm/Hyprland";
		hyprsysteminfo.url = "github:hyprwm/hyprsysteminfo";
		ghostty.url = "github:ghostty-org/ghostty";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	# Required by NixOS:
	# ./hardware-configuration.nix 

	# inputs.home-manager.nixosModules.default
	# catppuccin.nixosModules.catppuccin
	# nix-flatpak.nixosModules.nix-flatpak

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				inputs.nixos-hardware.nixosModules.common-gpu-nvidia
				inputs.home-manager.nixosModules.default
				inputs.catppuccin.nixosModules.catppuccin
				inputs.nix-flatpak.nixosModules.nix-flatpak
				./hosts/default/hardware-configuration.nix
				./hosts/default/configuration.nix
			];
		};
		nixosConfigurations.fix_nixpkgs = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./modules/nixos/nixpkgs.nix
				/etc/nixos/configuration.nix
			];
		};
	};
}
