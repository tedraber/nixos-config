{config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      source = ~/.config/hypr/monitors.conf
    '';
    
    settings = {
      
      "$mod" = "SUPER";

      bind = [
        "$mod, RETURN, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"
        
      ];
    };
  };
}
