{ inputs, pkgs, ... }:

let
    nmap = key: action: {
        mode = "n";
        inherit key action;
        noremap = true;
        silent = true;
    };
in
{
    imports = [ inputs.nvf.homeManagerModules.default ];

    programs.nvf = {
        enable = true;

        settings.vim = {
            globals = {
                mapleader = " ";
                maplocalleader = "\\";
            };

            options = {
                tabstop = 4;
                shiftwidth = 4;
                expandtab = true;
                smartindent = true;
                number = true;
                relativenumber = true;
                cmdheight = 0;
            };

            theme = {
                enable = true;
                name = "onedark";
                style = "dark";
            };

            startPlugins = [ pkgs.vimPlugins.nightfox-nvim ];

            # UI
            visuals = {
                nvim-web-devicons.enable = true;
                indent-blankline.enable = true;
                neoscroll-nvim.enable = true;
            };

            statusline.lualine.enable = true;
            tabline.nvimBufferline.enable = true;

            dashboard.alpha = {
                enable = true;
                theme = "dashboard";
            };

            # Editing
            treesitter.enable = true;
            utility.surround.enable = true;
            telescope.enable = true;

            git = {
                enable = true;
                gitsigns.enable = true;
            };

            filetree.nvimTree = {
                enable = true;
                openOnSetup = false;

                mappings = {
                    toggle = "<C-a>";
                    focus = "<leader>o";
                    refresh = null;
                    findFile = null;
                };

                setupOpts = {
                    actions.open_file.quit_on_open = true;
                    view = {
                        width = 30;
                        side = "left";
                    };
                    renderer.group_empty = true;
                    filters.dotfiles = false;
                    git.enable = true;
                };
            };

            terminal.toggleterm = {
                enable = true;
                lazygit = {
                    enable = true;
                    mappings.open = "<leader>lg";
                };
            };

            # LSP
            lsp = {
                enable = true;

                servers = {
                    clangd.root_markers = [ "CMakeLists.txt" "Makefile" "compile_commands.json" ];

                    spade = {
                        cmd = [ "swim" "lsp" ];
                        filetypes = [ "spade" ];
                        root_markers = [ "swim.toml" ];
                    };
                };
            };

            filetype.extension.spade = "spade";

            autocomplete.nvim-cmp.enable = true;
            snippets.luasnip.enable = true;

            languages = {
                enableTreesitter = true;

                nix.enable = true;
                rust.enable = true;
                clang.enable = true;
                python.enable = true;
            };

            keymaps = [
                (nmap "<leader>," "<Cmd>BufferLineCyclePrev<CR>")
                (nmap "<leader>." "<Cmd>BufferLineCycleNext<CR>")
                (nmap "<leader>q" "<Cmd>bdelete<CR>")
                (nmap "<leader>w" "<Cmd>bd<CR>")
                (nmap "<leader>ss" ":w<CR>")
                (nmap "<leader>ff" ":Telescope find_files<CR>")
                (nmap "<leader>p" "<Cmd>Telescope<CR>")
                (nmap "K" "<cmd>lua vim.lsp.buf.hover()<cr>")
                (nmap "gl" "<cmd>lua vim.diagnostic.open_float()<cr>")
            ];
        };
    };
}
