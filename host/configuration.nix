{ config, lib, pkgs, ... }:

{
    imports = [ ./hardware.nix ];

    # Nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "26.05";

    # Boot
    boot.loader = {
        timeout = 0; # Hold Space while booting to get the menu
        efi.canTouchEfiVariables = true;

        systemd-boot = {
            enable = true;
            configurationLimit = 10;
            editor = true; # Lets you press `e` on an entry to fix a broken boot
        };
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.systemd.enable = true;

    boot.consoleLogLevel = 0;
    boot.kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto" # Only show status lines if something is slow or fails
    ];

    boot.plymouth = {
        enable = true;
        theme = "bgrt";
    };

    # systemd tuning
    systemd.settings.Manager = {
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "10s";
    };

    # Stop networkmanager from fucking up in `systemd-analyze blame`
    systemd.services.NetworkManager-wait-online.enable = false;

    # Basic shit
    networking = {
        hostName = "v9";
        networkmanager.enable = true;
    };

    time.timeZone = "Asia/Kolkata";
    i18n.defaultLocale = "en_US.UTF-8";

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.shells = with pkgs; [ zsh ];
    environment.systemPackages = with pkgs; [
        vim
        wget
        git
        zsh
    ];

    # Users & shell
    users.users.v9 = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable 'sudo' for the user
        shell = pkgs.zsh;
        packages = with pkgs; [
            tree
        ];
    };

    programs.zsh = {
        enable = true;
        enableGlobalCompInit = false;
    };

    # Desktop: login + compositor
    programs.niri = {
        enable = true;
        package = pkgs.niri;
    };

    services.displayManager.ly = {
        enable = true;
        settings = {
            animation = "none";
            session_log = "~/.ly_session.log";
        };
    };

    # Fonts
    fonts.packages = with pkgs; [
        iosevka
        nerd-fonts.roboto-mono
    ];

    # Hardware
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true;
    };

    services.blueman.enable = true;

    # Auto mounting
    services.udisks2 = {
        enable = true;
        mountOnMedia = true;
    };
    services.gvfs.enable = true;

    # SSH / keyring
    programs.ssh.startAgent = true;
    services.gnome.gcr-ssh-agent.enable = false;
}
