{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./waybar
    ./shell/zsh.nix
    ./shell/bash.nix
    ./terminal/kitty.nix
    ./programs.nix
  ];

  home.username = "ollie";
  home.homeDirectory = "/home/ollie";

  home.stateVersion = "26.05"; # Don't change

  home.packages = with pkgs; [
    (callPackage ./packages/brave-origin.nix { })
    discord-ptb
    claude-code
    quickshell
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
