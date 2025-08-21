{
	description = "I use Nix BTW... I'm Hyprlanding it!!";
	# I use Nix BTW -> @iUseNixBTW (https://roblox.com/users/1083030325)
	# totally not a flex btw

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		catppuccin.url = "github:catppuccin/nix";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
		hyprland = {
			url = "github:hyprwm/Hyprland";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprlock.url = "github:hyprwm/hyprlock";
		hyprsysteminfo.url = "github:hyprwm/hyprsysteminfo";
		ghostty.url = "github:ghostty-org/ghostty";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		zen-browser.url = "github:0xc000022070/zen-browser-flake";

		home-manager = {
			url = "github:nix-community/home-manager";
			# inputs.nixpkgs.follows = "nixpkgs";
		};

		tuxstrap = {
			url = "github:ocbwoy3/tuxstrap/dev";
			# inputs.nixpkgs.follows = "nixpkgs";
		};

		nvf.url = "github:notashelf/nvf";

		tangled.url = "git+https://tangled.sh/@tangled.sh/core";

		# quickshell = {
		# 	url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
		# 	# inputs.nixpkgs.follows = "nixpkgs";
		# };


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
				# inputs.nixos-hardware.nixosModules.common-gpu-nvidia
				inputs.home-manager.nixosModules.default
				inputs.catppuccin.nixosModules.catppuccin
				inputs.nix-flatpak.nixosModules.nix-flatpak
				# ./hosts/default/hardware-configuration.nix
				
				# lil hack to not use --impure when rebuilding nixos >:3
				"/etc/nixos/hardware-configuration.nix"
				
				./hosts/default/configuration.nix
			];
		};
		nixosConfigurations.server = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				inputs.catppuccin.nixosModules.catppuccin

				# lil hack to not use --impure when rebuilding nixos >:3
				"/etc/nixos/hardware-configuration.nix"
				
				./hosts/server/configuration.nix
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
