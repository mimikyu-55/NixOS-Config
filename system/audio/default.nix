{ pkgs, ... }:
{
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32bit = true;
        pulse.enable = true;
    }
}