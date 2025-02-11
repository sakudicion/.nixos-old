{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # additional packages to add to gjs's runtime
    extraPackages = [
      inputs.ags.packages.${pkgs.system}.default
      inputs.ags.packages.${pkgs.system}.astal3
      inputs.ags.packages.${pkgs.system}.ags
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.notifd
    ];
  };

  home.file = {
    "${config.xdg.configHome}/ags" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixos/modules/hyprland/rice/ags";
    };
  };

  home.packages = [
    pkgs.matugen
    pkgs.swww
    pkgs.bun
    pkgs.dart-sass
    pkgs.gvfs
    pkgs.sassc
    pkgs.fd
    pkgs.brightnessctl
    pkgs.swww
    pkgs.wl-clipboard
    pkgs.hyprpicker
    pkgs.pavucontrol
    pkgs.gtk3
    pkgs.libnotify
  ];
}
