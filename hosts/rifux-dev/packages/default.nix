{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable CUPS to print documents & select Pantum driver.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.pantum-driver ];
  environment.systemPackages = with pkgs; [
    #
  ];
}
