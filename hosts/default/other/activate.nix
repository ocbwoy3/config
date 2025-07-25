{ config, inputs, pkgs, lib, ... }:

{

	environment.systemPackages = [
		(pkgs.callPackage ./../packages/ocbwoy3-icons/default.nix {})
	];

	system.nixos = {
		extraOSReleaseArgs = {
			LOGO="boykisser";
		};
	};

	system.name = "ocbwoy3";
	system.nixos.label = "ocbwoy3-config-main";
	boot.loader.grub.configurationName = lib.mkDefault "ocbwoy3/config:main";

	system.activationScripts.reloadFonts = {
		text = ''
			trap "${pkgs.fontconfig}/bin/fc-cache" EXIT
		'';
	};

	system.activationScripts.xdgDesktopPortal = {
		text = ''
			echo "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk" > /.xdg.sh
		'';
	};

}
