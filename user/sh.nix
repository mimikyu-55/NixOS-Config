{ config, pkgs, ... }:
{
    programs.bash = {
        enable = true;
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = false;
    };

    programs.kitty = {
        enable = true;
        settings = {
            shell = "zsh";
        };
    };
}