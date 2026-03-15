{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # This handles the systemd/dbus stuff automatically [cite: 19]
    systemd.enable = true; 

    settings = {
      # ONLY ONE exec-once list here 
      exec-once = [
        "dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"
        "${config.home.homeDirectory}/.nix-profile/bin/ambxst"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_options = "caps:escape"; # MUST HAVE QUOTES 
      };

      xwayland = {
        force_zero_scaling = true; # [cite: 3]
      };

      general = {
        layout = "dwindle"; # [cite: 5]
      };

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "STEAM_FORCE_DESKTOPUI_SCALING,1"
      ]; # [cite: 6]

      dwindle = {
        preserve_split = true; # [cite: 7]
        force_split = 2; # [cite: 8]
      };

      "$mod" = "SUPER"; # [cite: 9]

      bind = [
        "$mod, Q, killactive" # [cite: 9]
        "$mod, B, exec, helium" # [cite: 9]
      ];

      bindm = [
        "$mod, mouse:272, movewindow" # [cite: 10]
        "$mod, mouse:273, resizewindow" # [cite: 10]
      ];
    };
  };
}
