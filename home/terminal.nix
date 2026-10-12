{ pkgs, ... }:

{
    programs.kitty = {
        enable = true;

        font = {
            name = "Iosevka";
            size = 20;
        };

        settings = {
            background_opacity = "0.9";
            scrollback_lines = 10000;
            confirm_os_window_close = 0;
            enable_audio_bell = false;
            window_padding_width = 0;
            hide_window_decorations = "yes";
        };

        extraConfig = ''
            include dank-theme.conf
            include dank-tabs.conf
        '';
    };
}
