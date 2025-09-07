{ config, pkgs, inputs, username, ... }:

{
  # Home Manager configuration for user "me"
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = [
    # Add packages here, for example:
    # pkgs.neovim
    # pkgs.git
    # pkgs.ripgrep
  ];
}
