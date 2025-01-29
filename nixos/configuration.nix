# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking configuration
  networking = {
    hostName = "nixos-laptop";
    networkmanager.enable = true;
  };

  # Enable X11 and KDE
  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Printing support
  services.printing.enable = true;

  # Audio configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;

  # System-wide settings
  time.timeZone = "Europe/London";
  nixpkgs.config.allowUnfree = true;
  console.keyMap = "uk";

  # Locale settings
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # ZSH system-wide configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Enable Docker system-wide
  virtualisation = {
    docker = {
      enable = true;
      # Enable rootless mode
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  # Core system packages
  environment.systemPackages = with pkgs; [
    wget
    git
    toybox
    gnumake
    nixfmt-rfc-style
  ];

  # User configuration
  users.users.bentaylor = {
    isNormalUser = true;
    description = "Ben Taylor";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # Font settings
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # Enable automatic downloads of store paths
      trusted-users = [
        "root"
        "@wheel"
      ];
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Automatic store optimization
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Enable automatic updates
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    flags = [
      "--flake"
      ".#nixos-laptop"
    ];
    allowReboot = false; # Set to true if you want automatic reboots
  };

  security.sudo.wheelNeedsPassword = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11"; # Did you read the comment?
}
