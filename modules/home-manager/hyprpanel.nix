{ inputs, ... }:

{
	imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  
	programs.hyprpanel = {
		enable = true;
		systemd.enable = true;
		overwrite.enable = true;
	};
}
