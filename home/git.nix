{ ... }:

{
    programs.git = {
        enable = true;
        settings = {
            user.name = "Vaimer9";
            user.email = "vaim3r9@gmail.com";
            init.defaultBranch = "main";
            pull.rebase = true;
        };
    };
}
