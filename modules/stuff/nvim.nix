{ config, inputs, pkgs, lib, ... }:

{
	imports = [
		inputs.nvf.nixosModules.default
	];

	programs.nvf = {
		enable = true;
		defaultEditor = true;
		# withLua = true;

		settings.vim = {
			viAlias = true;
			vimAlias = true;
			statusline.lualine.enable = true;
			languages = {
				enableLSP = true;
				enableTreesitter = true;

				nix.enable = true;
				ts.enable = true;
				# qml.enable = true;
			};
		};
	};
}
