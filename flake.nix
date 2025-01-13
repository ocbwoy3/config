{
	description = "OCbwoy3's Dotfiles";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		catppuccin.url = "github:catppuccin/nix";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
		hyprland.url = "github:hyprwm/Hyprland";
		hyprsysteminfo.url = "github:hyprwm/hyprsysteminfo";
		ghostty.url = "github:ghostty-org/ghostty";
		
		hyprpanel.url = "github:jas-singhfsu/hyprpanel";
		hyprpanel.inputs.nixpkgs.follows = "nixpkgs";

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
				{
					nixpkgs.overlays = [inputs.hyprpanel.overlay];
				}
				inputs.home-manager.nixosModules.default
				inputs.catppuccin.nixosModules.catppuccin
				inputs.nix-flatpak.nixosModules.nix-flatpak
				/etc/nixos/hardware-configuration.nix
				./hosts/default/configuration.nix
			];
		};
	};
}
