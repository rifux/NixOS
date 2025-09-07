{
  description = "rifux.dev's Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Add lanzaboote for Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lanzaboote,
      ...
    }@inputs:
    let
      # Import our factory
      lib = import ./lib {
        inherit self inputs;
      };

    in
    {
      # Use the factory to build configurations
      nixosConfigurations = lib.genHosts {
        rifux-dev = {
          # You can override defaults here if needed
          # For example:
          # username = "custom-name";
        };
      };
    };
}
