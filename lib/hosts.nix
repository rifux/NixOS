{ self, inputs, ... }:

let
  # This is "factory" function
  mkHost =
    hostDir:  # Which folder has this computer's settings
    {
      arch ? "x86_64-linux",           # Default processor type
      hostname ? hostDir,              # Default name = folder name
      username ? "me",                 # Default username
      userDescription ? "Rifux User",  # Default user description
    }:
    # Now build the configuration
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      specialArgs = {
        inherit inputs self hostname username userDescription;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${arch};
      };
      modules = [

        # Basic settings for all computers
        {
          nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
            auto-optimise-store = true;
          };
          
          nixpkgs.config.allowUnfree = true; 
        }
        
        # Home Manager (for user settings)
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = { ... }: {
            imports = [ "${self}/hosts/${hostDir}/home.nix" ];
            _module.args = {
              inherit username inputs self;
            };
          };
        }

        # Lanzaboote for Secure Boot
        inputs.lanzaboote.nixosModules.lanzaboote
        
        # All shared modules
        "${self}/modules/audio.nix"
        "${self}/modules/bluetooth.nix"
        "${self}/modules/boot.nix"
        # "${self}/modules/niri"  # TODO
        # "${self}/modules/waybar.nix"  # TODO
        "${self}/modules/plasma.nix"
        "${self}/modules/proxy.nix"
        "${self}/modules/system.nix"
        "${self}/packages/default.nix"
        # "${self}/packages/security.nix"  # TODO
        "${self}/packages/virtualisation.nix"
        
        # This computer's specific settings
        "${self}/hosts/${hostDir}/default.nix"
        "${self}/hosts/${hostDir}/hardware-configuration.nix"

        # Syncthing
        {
          services.syncthing = {
            enable = true;
            user = "${username}";  # Spawn as user service
            dataDir = "/home/${username}";  # Default location for new folders
            configDir = "/home/${username}/.config/syncthing";
            openDefaultPorts = true;    # Open ports in the firewall for Syncthing
          };
        }

      ];
    };
in
{
  mkHost = mkHost;  # Export the factory function
  genHosts = builtins.mapAttrs mkHost;  # Export the assembly line
}
