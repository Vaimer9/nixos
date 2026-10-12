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
        inputs.spotifast.packages.${pkgs.system}.default
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    services.udiskie.enable = true;
}
