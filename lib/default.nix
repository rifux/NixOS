{ self, inputs }:
let
  hosts = import ./hosts.nix { inherit self inputs; };
in
{
  # Export the hosts functions
  inherit (hosts) mkHost genHosts;
}
