{config, pkgs, inputs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;  
    extraConfig = ''
      xwayland {
        force_zero_scaling = true
      }
      source = ~/.config/hypr/monitors.conf
    '';

    settings = {
      exec-once = "ambxst";
      
      input = {
        kb_layout="us";
        kb_variant="colemak";
        kb_options= caps:escape;
      };

      general = {
        layout = "dwindle";
      };

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "STEAM_FORCE_DESKTOPUI_SCALING,1"
      ];
      
      dwindle = {
        # Keeps the split direction based on the cursor position
        preserve_split = true; 
        # 0 = hex (default), 1 = human (split follows mouse), 2 = steered
        force_split = 2;
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, killactive"
        "$mod, B, exec, helium"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
