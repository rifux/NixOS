{ config, lib, pkgs, ... }:

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
  ];
}
