{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    # Install the package you need (proxychains or proxychains-ng)
    pkgs.v2rayn
    pkgs.xray

    # Add .desktop entries for proxy-enabled apps
    (pkgs.makeDesktopItem {
      name = "Vesktop (Proxy)";
      desktopName = "Vesktop (Proxy)";
      exec = "vesktop --proxy-server=0.0.0.0:10808 %U";
      icon = "vesktop";
      type = "Application";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
      #genericName = "Internet Messenger (Proxy)";
      keywords = [
        "discord"
        "vencord"
        "electron"
        "chat"
        "proxy"
      ];
      comment = "Discord mod accessed through proxychains";
      startupWMClass = "Vesktop";
    })
  ];
}
