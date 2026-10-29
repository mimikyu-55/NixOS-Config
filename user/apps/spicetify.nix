{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.comfy;
    colorScheme = "Lunar";
  };
}
