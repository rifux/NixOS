{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  options.programs.custom.niri = {
    enable = lib.mkEnableOption "Niri WM";
  };

  config = lib.mkIf config.programs.custom.niri.enable {
    # System-Level Configuration
    programs.niri.enable = true;

    # User-Level Configuration
    home-manager.users.${username} = {
      # Link to external KDL file
      xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

      # User packages
      home.packages = with pkgs; [
        waybar
        foot
        fuzzel
        grimblast
        yazi
        mako
        swaybg
        cliphist
        wl-clip-persist
        brightnessctl
        nwg-displays
        networkmanager_dmenu
        zellij
      ];
    };
  };
}
