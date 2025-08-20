{ config, inputs, pkgs, lib, ... }:

{

	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		zsh-autoenv.enable = true;
		syntaxHighlighting.enable = true;
		ohMyZsh = {
			enable = true;
			plugins = [ "git" "direnv" ];
			theme = "robbyrussell";
		};
		shellAliases = {
			nixrebuild = "sudo nixos-rebuild switch --flake .#default --impure --cores 4 -L --upgrade";
			dangerous-nixrebuild-server = "sudo nixos-rebuild switch --flake .#server --impure --cores 4 -L --upgrade";
			neofetch = "fastfetch";
		};
	};

}
