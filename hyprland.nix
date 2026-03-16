{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true; 

    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"
        "${config.home.homeDirectory}/.nix-profile/bin/ambxst"
      ];

      source = [
        "~/.config/hypr/monitors.conf"
      ];
      
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_options = "caps:escape";
      };

      xwayland = {
        force_zero_scaling = true; 
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
        preserve_split = true; 
        force_split = 2; 
      };

      "$mod" = "SUPER"; 

      bind = [
        "$mod, Q, killactive" 
        "$mod, B, exec, helium" 
        "$mod, E, exec, nautilus --new-window"
      ];

      bindm = [
        "$mod, mouse:272, movewindow" 
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
