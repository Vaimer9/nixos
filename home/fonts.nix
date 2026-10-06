{ pkgs, ... }:

{
    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            monospace = [ "Iosevka Nerd Font" ];
        };
    };

    home.packages = with pkgs; [
        nerd-fonts.iosevka
        nerd-fonts.roboto-mono
    ];
}
