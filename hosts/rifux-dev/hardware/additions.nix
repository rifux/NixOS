# Additions to our auto-generated hardware-configuration.nix

{ config, pkgs, lib, ... }:

{
  fileSystems."/".options = [ "rw" "noatime" "discard=async" "compress=zstd:3" "space_cache=v2" ];

  fileSystems."/home".options = [ "rw" "noatime" "discard=async" "compress=zstd:3" "space_cache=v2" ];

  fileSystems."/nix".options = [ "rw" "noatime" "discard=async" "compress=zstd:3" "space_cache=v2" ];

  fileSystems."/.snapshots".options = [ "rw" "noatime" "discard=async" "compress=zstd:3" "space_cache=v2" ];

  fileSystems."/boot".options = [ "rw" "noatime" ];
}
