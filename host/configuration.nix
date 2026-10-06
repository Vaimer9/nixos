{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "v9";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";


  users.users.v9 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.roboto-mono
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;

  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };
  
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/v9";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    alacritty
    chromium
    vim
    wget
    neovim
    polkit_gnome
    xdg-desktop-portal-hyprland
    hyprlock
    hypridle
    fastfetch
    git
    alacritty
    fuzzel
    repomix
    wl-clipboard
    zsh
    fzf
    gnumake
    discord
    ripgrep
    obsidian
    kitty
    zsh
    legcord
    eza
    bat
  ];
  environment.shells = with pkgs; [ zsh ];

  system.stateVersion = "26.05";
}
