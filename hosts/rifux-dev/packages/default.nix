{ config, lib, pkgs, ... }:

{  
  environment.systemPackages = with pkgs; [
    pantum-driver # For printer
  ];
}
