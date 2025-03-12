{ config, pkgs, ... }:

{
	
	programs.fastfetch = {
		enable = true;
		settings = {
			# Example: Change colors and add custom options
			logo = "nixos";
			color = "blue";
			keyColor = "cyan";
			separator = " => ";
		};
	};
	
}
