{ config, lib, pkgs, ... }:

{
  # Required packages for functionality
  environment.systemPackages = with pkgs; [
    bluez           # Bluetooth stack (provides bluetoothctl)
    bluez-tools     # Optional: Additional CLI tools (remove if unwanted)
  ];

  # Fixes common pairing issues
  hardware.bluetooth = {
  	enable = true;
  	powerOnBoot = true;
  	settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
  	  };
  	};
  }; 
}
