{ config, pkgs, ... }:

{
    imports = [
        ./shell/zsh.nix
        ./shell/bash.nix
        ./terminal/kitty.nix
        ./programs.nix
    ];

    home.username = "ollie";
    home.homeDirectory = "/home/ollie";

    home.stateVersion = "26.05"; # Don't change

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
        brave
        discord-ptb
    ];

    home.file = {

    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
