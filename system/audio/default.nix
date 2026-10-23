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

  # Prefer the GameDAC as the default output; the DualSense speaker/mic come last
  services.pipewire.wireplumber.extraConfig."20-default-device-priority" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          { "node.name" = "alsa_output.usb-SteelSeries_*.playback.0.0"; }
        ];
        actions.update-props = {
          "priority.driver" = 2000;
          "priority.session" = 2000;
        };
      }
      {
        matches = [
          { "node.name" = "alsa_output.usb-Sony_Interactive_Entertainment_DualSense_*"; }
          { "node.name" = "alsa_output.hw_Controller_*"; }
          { "node.name" = "alsa_input.usb-Sony_Interactive_Entertainment_DualSense_*"; }
        ];
        actions.update-props = {
          "priority.driver" = 100;
          "priority.session" = 100;
        };
      }
    ];
  };
}
