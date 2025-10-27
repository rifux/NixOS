{
  pkgs,
  config,
  lib,
  ...
}:

let
  kver = config.boot.kernelPackages.kernel.version;
in
{
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;

  boot =
    let
      # Define all static kernel parameters here
      extraKernelParams = [
        "kvm.enable_virt_at_load=0" # AMD-V support (for VirtualBox)
        "amdgpu.abmlevel=3" # Adaptive Backlight Management (ABM)
        "nvme.noacpi=0" # Just to be sure the system won't be freezed
      ];
    in
    lib.mkMerge [
      (lib.mkIf ((lib.versionAtLeast kver "5.17") && (lib.versionOlder kver "6.1")) {
        kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ] ++ extraKernelParams;
        kernelModules = [ "amd-pstate" ];
      })
      (lib.mkIf ((lib.versionAtLeast kver "6.1") && (lib.versionOlder kver "6.3")) {
        kernelParams = [ "amd_pstate=passive" ] ++ extraKernelParams;
      })
      (lib.mkIf (lib.versionAtLeast kver "6.3") {
        kernelParams = [ "amd_pstate=active" ] ++ extraKernelParams;
      })
    ];

  # CPUPower
  environment.systemPackages = [ pkgs.linuxPackages.cpupower ];

  # Powersaving
  services.thermald.enable = true;

  # Disable PPD (inefficient)
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      START_CHARGE_THRESH_BAT0 = 70; # at 70 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # at 80 it stops charging

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on"; # Enable Wi-Fi power saving

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave"; # Most aggressive PCIe power saving

      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 2;

      RADEON_POWER_PROFILE_ON_AC = "auto";
      RADEON_POWER_PROFILE_ON_BAT = "low";
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      MEM_SLEEP_ON_AC = "s2idle";
      MEM_SLEEP_ON_BAT = "deep";

      USB_AUTOSUSPEND = 1;

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };
}
