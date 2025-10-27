{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Rootless Docker
  virtualisation.docker = {
    # Consider disabling the system wide Docker daemon
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
      # Optionally customize rootless Docker daemon settings
      daemon.settings = {
        dns = [ "9.9.9.9" ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
    };
  };

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;

  # Distrobox
  virtualisation.podman = {
    enable = true;
  };

  # KVM
  /*
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        # runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
  */

  environment.systemPackages = with pkgs; [
    # gnome-boxes
    distrobox
    boxbuddy
    # dnsmasq
    # phodav
  ];
}
