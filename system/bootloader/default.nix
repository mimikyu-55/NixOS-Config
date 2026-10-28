{ config, lib, ... }:
{
  imports = [
    ./grub.nix
    ./lanzaboote.nix
  ];

  options.bootloader.type = lib.mkOption {
    type = lib.types.enum [
      "grub"
      "lanzaboote"
    ];
    default = "grub";
    description = "Which bootloader configuration to use.";
  };

  config.boot.loader.efi.canTouchEfiVariables = true;
}
