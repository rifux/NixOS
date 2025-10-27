# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  hostname,
  username,
  ...
}:

{
  imports = [
    # LVM on LUKS2 with ZRAM and NVMe improvements
    ./hardware/additions.nix
    ./hardware/luks.nix
    # Device-specific
    ./../../device/thinkpad-amd.nix # ThinkPad AMD tweaks
    # Japanese
    ./../../pkg/Japanese.nix
    # Additional specific packages
    ./packages
  ];

  # Hostname
  networking.hostName = hostname;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use firmware
  hardware.enableAllFirmware = true;

  # Add fish shell
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "vboxusers"
      "adbusers"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # Firewall-allowed ports
  networking.firewall.allowedTCPPorts = [
    53317 # LocalSend
    53049 # qBittorrent
  ];

  # Change DNS
  networking.nameservers = [ "9.9.9.9" ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
