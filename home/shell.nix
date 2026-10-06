{ ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            ls = "eza";
            edit = "sudoedit";
            update = "sudo nixos-rebuild switch --flake $HOME/.config/nixos";
        };

        antidote = {
            enable = true;
            plugins = [
                "zsh-users/zsh-autosuggestions"
            ];
        };

        history = {
            size = 10000;
            ignoreAllDups = true;
            path = "$HOME/.history";
        };
    };
}
