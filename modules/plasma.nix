{
  config,
  lib,
  pkgs,
  ...
}:

{
  # KDE Plasma 6 with Wayland and SDDM
  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  # Ensure KWallet is properly integrated
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # Exclude packages you don't want
  ];

  # Enable PAM for KWallet integration
  security.pam.services = {
    sddm.enableKwallet = true;
    kde.enableKwallet = true;
  };
}
