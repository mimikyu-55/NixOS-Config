{ config, pkgs, ... }:
let
  p5r-grub = pkgs.fetchFromGitHub {
    owner = "SiriusAhu";
    repo = "Persona_5_Royal_Grub_Themes";
    rev = "07f4660631d6002aafe9f14dfa77849e979477ac";
    hash = "sha256-/4i5Br3f7FlQcy5GFIRcycGR7gPVemElJc5uyi2LgRc=";
  };
in
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    theme = "${p5r-grub}/themes/navi";
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
