{
  config,
  lib,
  pkgs,
  ...
}:

{
  # ZRAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # or adjust as needed
  };

  # Networking
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";

  # Libinput (TouchPad)
  services.libinput.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kuwait";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    #   font = "Lat2-Terminus16";
    keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
  };
}
