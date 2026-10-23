{ pkgs, ... }:

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # WirePlumber ACP override (safe + stable)
  services.pipewire.wireplumber.extraConfig."10-steelseries-disable-acp" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          # This match is stable across PipeWire versions
          { "api.alsa.card.name" = "SteelSeries GameDAC"; }
        ];
        actions.update-props = {
          "api.alsa.use-acp" = false;
        };
      }
    ];
  };
}
