{ config, inputs, pkgs, ... }:

{

	environment.systemPackages = with pkgs; [
		cloudflared
	];
	
	# lib.mkIf (isOCbwoy3 == true)
	services.cloudflared = {
		enable = true;
		certificateFile = "/private/cloudflared.pem"
		tunnels = {
			"selfhost" = {
				# 2f83f704-e9f7-49fb-a6c4-d4a8f85d87e4
				default = "http_status:404";
				credentialsFile = "/private/cloudflared/selfhost.json";
				ingress = {
					"api.ocbwoy3.dev" = {
						service = "http://localhost:8080";
					};
					"remx-staging.darktru.win" = {
						service = "http://localhost:3000";
					};
					"pds.darktru.win" = {
						service = "http://localhost:80";
					};
				};
			};
		};
	};

}
