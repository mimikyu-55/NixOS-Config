{ config, pkgs, ... }:
{
    programs.vscodium = {
        enable = true;
    };

    programs.git = {
        enable = true;
    
        settings = {
            user.name = "Oliver";
            user.email = "oliverbarcock@gmail.com";

            init.defaultBranch = "main";
            pull.rebase = true;
        };
    };
}