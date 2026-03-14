{config, pkgs, ...}:

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
      input = {
        kb_layout="us";
        kb_variant="colemak";
        kb_options= caps:escape;
      };

      general = {
        layout = "dwindle";
      };

      exec-once = [
        "ambxst"
      ];
      
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
        "$mod, T, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, B, exec, helium"
        "$mod, E, exec, nautilus --new-window"

        # Move focus/windows with keys
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Resize windows with keys
        "$mod SHIFT, left, resizeactive, -20 0"
        "$mod SHIFT, right, resizeactive, 20 0"
        "$mod SHIFT, up, resizeactive, 0 -20"
        "$mod SHIFT, down, resizeactive, 0 20"

        # Move active window with mod + SHIFT + hjkl
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        "$mod, P, pseudo," # toggle pseudo-tiling
        "$mod, G, togglesplit," # change split direction (horizontal/vertical)

        "$mod SHIFT, F, fullscreen"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
