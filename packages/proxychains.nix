{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.etc."proxychains.conf".text = ''
    strict_chain
    proxy_dns

    [ProxyList]
    socks5 127.0.0.1 10808 # V2rayN
  '';

  environment.systemPackages = [
    # Install the package you need (proxychains or proxychains-ng)
    pkgs.proxychains-ng

    # Add .desktop entries for proxy-enabled apps
    (pkgs.makeDesktopItem {
      name = "Komikku (Proxy)";
      desktopName = "Komikku (Proxy)";
      exec = "proxychains4 komikku";
      icon = "info.febvre.Komikku";
      type = "Application";
      categories = [
        "Graphics"
        "Network"
        "Viewer"
      ];
      keywords = [
        "manga"
        "reader"
        "viewer"
        "comic"
        "manhwa"
        "manhua"
        "bd"
        "webtoon"
        "webcomic"
        "scan"
        "offline"
        "GTK"
        "GNOME"
      ];
      comment = "Access Komikku via proxychains";
      startupWMClass = "Komikku";
    })
  ];
}
