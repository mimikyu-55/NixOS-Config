{ config, pkgs, ... }:
{
    boot.loader = {
        grub.enable = true;
        grub.device = "/dev/nvme0n1";
        grub.useOSProber = true;
    };
}