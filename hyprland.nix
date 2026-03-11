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

      general = {
        layout = "dwindle";
      };

      dwindle = {
        # Keeps the split direction based on the cursor position
        preserve_split = true; 
        # 0 = hex (default), 1 = human (split follows mouse), 2 = steered
        force_split = 2;
      };

      animations = {
        enabled = true;
        bezier = "overshot, 0.5, 0.9, 0.1, 1.1";
        animation = [
          "windows, 1, 5, overshot, slide"
          "workspaces, 1, 5, default, slidefade 20%"
        ];
      };
   
      "$mod" = "SUPER";

      bind = [
        "$mod, T, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, B, exec, helium"

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
