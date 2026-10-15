{ pkgs, inputs, ... }:

{
    imports = [ ./shell.nix ./git.nix ./terminal.nix ./fonts.nix ./dms.nix ];

    home.username = "v9";
    home.homeDirectory = "/home/v9";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [

        # ---- Desktop ----
        fuzzel
        kitty
        thunar
        polkit_gnome
        playerctl
        brightnessctl
        xwayland-satellite

        # ---- CLI utils ----
        neovim
        lazygit
        repomix
        wl-clipboard
        fzf
        gnumake
        ripgrep
        eza
        bat
        fastfetch

        # ---- Slop ----
        chromium
        obsidian
        spotify
        legcord
    
        # Input packages
        inputs.spotifast.packages.${pkgs.system}.default
        inputs.nix-auth.packages.${pkgs.system}.default
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    services.udiskie.enable = true;

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    systemd.user.services.xwayland-satellite = {
        Unit = {
            Description = "Xwayland satellite";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
        };
        Service = {
            Type = "simple";
            ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
            Restart = "on-failure";
            RestartSec = 3;
        };
        Install = {
            WantedBy = [ "graphical-session.target" ];
        };
    };
}
