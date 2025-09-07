{ config, lib, pkgs, ... }:

{
  # LUKS device to open before mounting / [root]
  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/a1092ce7-f97a-4018-a936-07cd7ebd0b68";
      allowDiscards = true;
      preLVM = true;
    };
  };

  # Corresponding packages
  environment.systemPackages = with pkgs; [
    btrfs-progs
    cryptsetup
    lvm2
  ];
}
