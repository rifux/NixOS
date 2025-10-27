{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Ensures proper real-time scheduling (fixes audio glitches):
  security.rtkit.enable = true;

  # Essential audio stack (PipeWire replaces PulseAudio/JACK)
  services.pipewire = {
    enable = true;
    alsa.enable = true; # ALSA compatibility
    alsa.support32Bit = true;
    pulse.enable = true; # PulseAudio compatibility
    wireplumber.enable = true;

    # Create virtual microphone specifically for AndroidMic
    #extraConfig.pipewire."99-androidmic-virtual" = {
    #  "context.objects" = [
    #    {
    #      factory = "adapter";
    #      args = {
    #        "factory.name" = "support.null-audio-sink";
    #        "node.name" = "AndroidMic-Virtual";
    #        "node.description" = "AndroidMic Virtual Microphone";
    #        "media.class" = "Audio/Source/Virtual";  # Virtual microphone input
    #        "audio.position" = "FL,FR";
    #      };
    #    }
    #  ];
    #};
  };

  # Required for desktop environments
  environment.systemPackages = with pkgs; [
    wireplumber # Default session manager (required)
    helvum # Optional: GUI patchbay (remove if unwanted)
    qpwgraph # For debugging
  ];
}
