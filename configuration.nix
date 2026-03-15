# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.nameservers = [ "1.1.1.1" "8.8.8.8"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  fileSystems."/mnt/drive2" = {
    device = "/dev/disk/by-uuid/c3ae2d91-fda5-4f65-afff-45f56a6f526c";
    fsType = "ext4";
    options = [ "defaults" "nofail"];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/drive2 077 root root -"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.i2c.enable = true;

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ted";
  programs.hyprland.enable = true;

  programs.gpu-screen-recorder.enable = true;
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  console.keyMap = "colemak";
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  hardware.keyboard.qmk.keychronSupport = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      nrsu = "sudo nixos-rebuild switch --upgrade --flake ~/nixos-config#nixos";
      quit = "exit";
    };
    
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo"];
      theme = "fwalch";
    };

   interactiveShellInit = ''
    # 1. zsh-fzf-tab (Load this BEFORE autocomplete/autosuggestions usually)
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh

    # 2. zsh-nix-shell
    source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

    # 3. zsh-fzf-history-search
    source ${pkgs.zsh-fzf-history-search}/share/zsh-fzf-history-search/zsh-fzf-history-search.zsh

    # 4. zsh-autosuggestions
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    # 5. zsh-autocomplete
    # source ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

  ''; 
   };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ted = {
    isNormalUser = true;
    description = "Theodore Raber";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "plugdev" "input" "i2c" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk"];
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   git
   helix
   zsh
   wget
   oh-my-zsh
   zsh-fzf-tab
   zsh-nix-shell
   zsh-fzf-history-search
   zsh-autosuggestions
   zsh-autocomplete
   openssh
   cifs-utils
   samba
   dig
   hyprland
   yazi
   rofi
   python3
   btop
   gotop
   wineWow64Packages.stable
   rustup
   direnv
   inputs.ambxst.packages.${pkgs.system}.default
  ];


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
