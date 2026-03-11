{config, pkgs, ...}

{
  wayland.windowManager.hyprland = {
    enable = true;

    source = [
      "~/.config/hypr/monitors.conf"
    ];

    settings = {
      monitor = ",preferred,auto,1";
      
      "mod" = "SUPER";

      bind = [
        "$mod, RETURN, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"
        
      ];
    };
  };
}
