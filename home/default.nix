{ pkgs, ... }:

{
    imports = [ ./shell.nix ./git.nix ./terminal.nix ./fonts.nix ./dms.nix ];

    home.username = "v9";
    home.homeDirectory = "/home/v9";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [

        # ---- Window Manager ----
        fuzzel
        kitty
        polkit_gnome

        # ---- CLI utils ----
        neovim
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
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };
}
