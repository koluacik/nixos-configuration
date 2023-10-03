{ pkgs, config, lib, ... }:
with lib;
{
  options.mySystem.hostOverridesForHomeManager = mkOption {
    type = types.attrsOf types.anything;
    default = { };
    description = "Host specific overrides to home manager configuration";
  };
}
