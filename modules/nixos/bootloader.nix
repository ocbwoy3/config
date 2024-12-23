{ config, pkgs, ... }:

{

	boot.binfmt.registrations.appimage = {
		wrapInterpreterInShell = false;
		interpreter = "${pkgs.appimage-run}/bin/appimage-run";
		recognitionType = "magic";
		offset = 0;
		mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
		magicOrExtension = ''\x7fELF....AI\x02'';
	};

	boot.supportedFilesystems = [ "ntfs" ];

	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
		};
		grub = {
			efiSupport = true;
			device = "nodev";
			# efiInstallAsRemovable = true;
			useOSProber = true;
			gfxmodeEfi = "1920x1080";
		};
	};

}
