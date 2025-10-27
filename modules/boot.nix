{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Lanzaboote replaces systemd-boot for Secure Boot
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable lanzaboote for Secure Boot
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Add sbctl for Secure Boot management
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # Use BTRFS
  boot.supportedFilesystems = [ "btrfs" ];

  # Enable dm-crypt
  boot.initrd.kernelModules = [
    "dm-crypt"
    "btrfs"
    "dm-mod"
  ];
}
