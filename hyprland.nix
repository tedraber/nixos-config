{config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      source = ~/.config/hypr/monitors.conf
    '';

    settings = {
      input = {
        kb_layout="us";
        kb_variant="colemak";
      };
      "$mod" = "SUPER";

      bind = [
        "$mod, T, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, B, exec, helium"
        
      ];
    };
  };
}
