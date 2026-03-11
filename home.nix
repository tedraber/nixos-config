{ config, inputs, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ted";
  home.homeDirectory = "/home/ted";

  home.packages = with pkgs; [
    nur.repos.Ev357.helium
    steam
    prismlauncher
    protonplus
    heroic
    vscode
    vesktop
    chromium
    ghostty
    deezer-enhanced
    kdePackages.qtdeclarative
    pavucontrol
    gemini-cli
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    size = 18;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    x11.enable = true;
  };
  
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "nord-night";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        mouse = false;
      };
    };
    languages = {
    language-server.qmlls = {
      command = "qmlls";
      args = ["-E"];
    };
    language = [{
      name = "qml";
      language-servers = [ "qmlls" ];
    }];  
  };
 };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
