{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        autocd = true;

        plugins = [
            {
                name = "zsh-vi-mode";
                src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
            }
        ];

        shellAliases = {
            ls = "eza";
            edit = "sudoedit";
            update = "sudo nixos-rebuild switch --flake $HOME/.config/nixos";
            gup = "git -C $HOME/.config/nixos add . && update";
            grep = "rg";
            lg = "lazygit";
            cpts = "repomix --stdout | wl-copy";
        };

        history = {
            path = "$HOME/.history";
        };
    };

    programs.starship = {
        enable = true;
        enableZshIntegration = true;

        settings = {
            format = "$git_branch$directory∮ ";
            right_format = "$nix_shell";

            cmd_duration.disabled = true;
            time.disabled = true;
            os.disabled = true;

            directory = {
                truncation_length = 3;
                home_symbol = "~";
            };

            git_branch = {
                format = "[($branch)]($style) ";
                style = "bold green";
            };

            add_newline = false;
        };
    };
}
