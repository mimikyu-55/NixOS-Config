{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.bootloader.type == "lanzaboote") {
    # lanzaboote replaces systemd-boot
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    environment.systemPackages = [ pkgs.sbctl ];
  };
}
