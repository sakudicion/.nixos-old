{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
		xfce.thunar
		xfce.thunar-volman
		xfce.thunar-archive-plugin
		xfce.thunar-media-tags-plugin
		xfce.tumbler
		ffmpegthumbnailer
	];

}
