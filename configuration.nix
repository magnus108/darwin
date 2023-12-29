{ pkgs, ... }:

{
  nix.settings = {
    substituters = [ "https://cache.iog.io" ];
    trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  };

  users.users.magnus = {
    home = "/Users/magnus";
    shell = pkgs.zsh;
  };

  environment = {
    shells = with pkgs; [ zsh ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
      #openlens
      neovim
      feh
      mpv
      graphviz
      ranger
      ripgrep
      dotnet-sdk_8
      highlight
      mono
      fzf
      git
      zip
      unzip
      tig
      gh
      nodejs_20
      dbeaver
      docker
      jetbrains.rider
      netcoredbg
      #jetbrains.webstorm
      vscode
      zsh
      telepresence2
      kubectl
      nixpkgs-fmt
      nil
      nodePackages.vscode-json-languageserver
      kitty
      # fix
      #qutebrowser-qt5
      omnisharp-roslyn
      tree-sitter-grammars.tree-sitter-query
      tree-sitter-grammars.tree-sitter-c
      tree-sitter-grammars.tree-sitter-c-sharp
      tree-sitter-grammars.tree-sitter-query
      tree-sitter-grammars.tree-sitter-lua
    ];
  };

  nixpkgs.config = { allowUnfree = true; };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  system = {
    stateVersion = 4;
    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 8;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleKeyboardUIMode = 3;
        AppleFontSmoothing = 2;
        _HIHideMenuBar = true;
      };
      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        tilesize = 40;
        static-only = true;
        show-recents = false;
      };
      finder = {
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  services = {

    #spacebar = {
    #enable = true;
    #package = pkgs.spacebar;
    #config = {
    #position = "bottom";
    #display = "all";
    #height = 26;
    #title = "off";
    #spaces = "off";
    #clock = "off";
    #power = "off";
    #padding_left = 20;
    #padding_right = 20;
    #spacing_left = 25;
    #spacing_right = 15;
    #text_font = ''"FiraCode:Regular:12.0"'';
    #icon_font = ''"Font Awesome 6 Free:Solid:12.0"'';
    #background_color = "0xff202020";
    #foreground_color = "0xffa8a8a8";
    #power_icon_color = "0xffcd950c";
    #battery_icon_color = "0xffd75f5f";
    #dnd_icon_color = "0xffa8a8a8";
    #clock_icon_color = "0xffa8a8a8";
    #power_icon_strip = " ";
    #space_icon = "•";
    #space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
    #spaces_for_all_displays = "on";
    #display_separator = "on";
    #display_separator_icon = "";
    #space_icon_color = "0xff458588";
    #space_icon_color_secondary = "0xff78c4d4";
    #space_icon_color_tertiary = "0xfffff9b0";
    #clock_icon = "";
    #dnd_icon = "";
    #clock_format = ''"%d/%m/%y %R"'';
    #right_shell = "on";
    #right_shell_icon = "";
    #right_shell_command = "whoami";

    #};
    #};

    skhd = {
      enable = true;
      skhdConfig = ''
        # Open Terminal
        lalt - return : open -na kitty
        lalt + shift - return : open -na Safari

        # Toggle Window
        lalt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
        lalt - f : yabai -m window --toggle zoom-fullscreen
        lalt - q : yabai -m window --close

        # Focus Window
        lalt - k : yabai -m window --focus north
        lalt - j : yabai -m window --focus south
        lalt - h : yabai -m window --focus west
        lalt - l : yabai -m window --focus east

        # Swap Window
        shift + lalt - k : yabai -m window --swap north
        shift + lalt - j : yabai -m window --swap south
        shift + lalt - h : yabai -m window --swap west
        shift + lalt - l : yabai -m window --swap east

        # Focus display (for now)
        lalt - 1 : yabai -m display --focus 1
        lalt - 2 : yabai -m display --focus 2

        # Send to Space
        shift + lalt - 1 : yabai -m window --space 1
        shift + lalt - 2 : yabai -m window --space 2
      '';
    };

    yabai = {
      enable = true;
      config = {
        layout = "bsp";

        top_padding = "10";
        bottom_padding = "10";
        left_padding = "10";
        right_padding = "10";
        window_gap = "10";

        auto_balance = "off";
        split_ratio = "0.50";

        window_placement = "second_child";

        focus_follows_mouse = "off";
        mouse_follows_focus = "off";

        window_topmost = "on";
        window_shadow = "float";
        window_opacity = "on";
        active_window_opacity = "1.0";
        normal_window_opacity = "0.9";

        external_bar = "all:0:26";
      };
    };
  };

  home-manager.users.magnus = { lib, pkgs, ... }: {
    home = { stateVersion = "22.05"; };
    home.activation.linkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
        ln -sfn $HOME/Documents/private/darwin/.tigrc $HOME/.tigrc
      '';

    programs = {
      #gh = {
      #  enable = true;
      #  extensions = [
      #  ];
      #};
      #gh-dash = {
      #  enable = true;
      #};

      noti.enable = true;
      navi.enable = true;

      #qutebrowser = {
      #  enable = true;
      #  package = pkgs.qutebrowser-qt5;
      #};

      kitty = {
        enable = true;
        theme = "Tokyo Night";
        darwinLaunchOptions = [ "--single-instance" "--directory=~" ];
        settings = {
          enable_audio_bell = false;
          update_check_interval = 24;
          hide_window_decorations = "titlebar-only";
          confirm_os_window_close = 0;
          #clear_all_mouse_actions = "yes";
          #clear_all_shortcuts = "yes";
          mouse_hide_wait = 3;
        };
        font.size = 11;
        font.name = "FiraCode Nerd Font Bold";
        extraConfig = ''
          map cmd+c        copy_to_clipboard
          map cmd+v        paste_from_clipboard
        '';
      };

      tmux = {
        enable = true;
        baseIndex = 1;
        historyLimit = 10240;
        mouse = true;
        keyMode = "vi";
        terminal = "screen-256color";
        shortcut = "a";
        disableConfirmationPrompt = true;
        #fix
        plugins = with pkgs.tmuxPlugins; [
          tmux-fzf
          vim-tmux-navigator
          cpu
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-strategy-nvim 'session'
              set -g @resurrect-capture-pane-contents 'on'
            '';
          }
          {
            plugin = continuum;
            extraConfig = ''
              set -g @continuum-boot 'on'
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '10' # minutes
              set -g @continuum-boot-options 'kitty'
            '';
          }
        ];
        extraConfig = ''
          set -g status off

          # Smart pane switching with awareness of Vim splits.
          # See: https://github.com/christoomey/vim-tmux-navigator
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
          bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
          bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
          bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
          bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
          tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
          if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'C-h' select-pane -L
          bind-key -T copy-mode-vi 'C-j' select-pane -D
          bind-key -T copy-mode-vi 'C-k' select-pane -U
          bind-key -T copy-mode-vi 'C-l' select-pane -R
          bind-key -T copy-mode-vi 'C-\' select-pane -l


          # Really?
          # set -ga terminal-overrides ",xterm-kitty:Tc"
        '';
      };

      git = {
        enable = true;
        userName = "Magnus Møller";
        userEmail = "magnus108@me.com";
        lfs.enable = true;
        extraConfig = {
          core = {
            excludesfile = "~/.gitignore";
            autocrlf = "input";
            ignorecase = false;
          };

          color.ut = "auto";
          branch.autoSetupRebase = "always";

          merge = {
            ff = "only";
          };

          pull = {
            rebase = "merges";
          };

          push = {
            autoSetupRebase = true;
            autoSetupRemote = true;
            default = "simple";
          };

          rerere.enabled = true;

          rebase = {
            autoSquash = true;
            abbreviateCommands = true;
          };

          mergetool.vimdiff.cmd =
            "nvim -d $LOCAL $MERGED $BASE $REMOTE -c 'wincmd w' -c 'wincmd j'";

          merge = {
            tool = "vimdiff";
            conflictStyle = "diff3";
          };

          diff = {
            tool = "vimdiff";
            mnemonicprefix = true;
          };

          grep = {
            lineNumber = true;
          };

        };
      };

      fzf = {
        tmux.enableShellIntegration = true;
      };

      neovim = {
        enable = true;
        #fix
        extraConfig = builtins.readFile ./vimrc.vim;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
        plugins = with pkgs.vimPlugins; [
          which-key-nvim
          vim-easymotion
          vim-repeat
          ranger-vim
          vim-obsession
          vim-tmux-navigator
          vim-nix
          telescope-nvim
          haskell-vim
          coc-nvim
          nvim-lspconfig
          omnisharp-extended-lsp-nvim
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          nvim-cmp
          cmp-vsnip
          vim-vsnip
          tokyonight-nvim
          nvim-dap
          nvim-dap-ui
          neotest
          neotest-dotnet
          neotest-haskell
          nvim-treesitter
          plenary-nvim
          nvim-tree-lua
          gitsigns-nvim
          FixCursorHold-nvim
        ];

        extraLuaConfig = ''
          -- disable netrw at the very start of your init.lua
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1





          -- Which-key configuration
          local wk = require("which-key")

          wk.setup {
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                  enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                  suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                  operators = true, -- adds help for operators like d, y, ...
                  motions = true, -- adds help for motions
                  text_objects = true, -- help for text objects triggered after entering an operator
                  windows = true, -- default bindings on <c-w>
                  nav = true, -- misc bindings to work with windows
                  z = true, -- bindings for folds, spelling and others prefixed with z
                  g = true, -- bindings for prefixed with g
                },
              },
              -- add operators that will trigger motion and text object completion
              -- to enable all native operators, set the preset / operators plugin above
              operators = { gc = "Comments" },
              key_labels = {
                -- override the label used to display some keys. It doesn't effect WK in any other way.
                -- For example:
                -- ["<space>"] = "SPC",
                -- ["<cr>"] = "RET",
                -- ["<tab>"] = "TAB",
              },
              motions = {
                count = true,
              },
              icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
              },
              popup_mappings = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
              },
              window = {
                border = "none", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                zindex = 1000, -- positive value to position WhichKey above other floating windows.
              },
              layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
              },
              ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
              hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
              show_help = true, -- show a help message in the command line for using WhichKey
              show_keys = true, -- show the currently pressed key and its label as a message in the command line
              triggers = "auto", -- automatically setup triggers
              -- triggers = {"<leader>"} -- or specifiy a list manually
              -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
              triggers_nowait = {
                -- marks
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                '"',
                "<c-r>",
                -- spelling
                "z=",
              },
              triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for keymaps that start with a native binding
                i = { "j", "k" },
                v = { "j", "k" },
              },
              -- disable the WhichKey popup for certain buf types and file types.
              -- Disabled by default for Telescope
              disable = {
                buftypes = {},
                filetypes = {},
              },
          }




          local nvim_tree_bindings = {
            ["e"] = {":NvimTreeToggle<CR>", "Toggle Nvim-Tree"},
            ["f"] = {":NvimTreeFocus<CR>", "Focus Nvim-Tree"},
            ["r"] = {":NvimTreeFindFile<CR>", "Reveal in Nvim-Tree"}
          }


          wk.register({
            n = {
              name = "+nvim-tree", -- Optional group name
              nvim_tree_bindings
            }
          }, { prefix = "<leader>" })








          require('gitsigns').setup {
            signs = {
              add          = { text = '│' },
              change       = { text = '│' },
              delete       = { text = '_' },
              topdelete    = { text = '‾' },
              changedelete = { text = '~' },
              untracked    = { text = '┆' },
            },
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
              follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
              virt_text = true,
              virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
              delay = 1000,
              ignore_whitespace = false,
              virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
              -- Options passed to nvim_open_win
              border = 'single',
              style = 'minimal',
              relative = 'cursor',
              row = 0,
              col = 1
            },
            yadm = {
              enable = false
            },
          }


          local gitsigns_bindings = {
            ["s"] = {":Gitsigns stage_hunk<CR>", "Stage Hunk"},
            ["u"] = {":Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk"},
            ["r"] = {":Gitsigns reset_hunk<CR>", "Reset Hunk"},
            ["p"] = {":Gitsigns preview_hunk<CR>", "Preview Hunk"},
            ["B"] = {":Gitsigns blame_line<cr>", "Blame line"},
            ["b"] = {":Gitsigns toggle_current_line_blame<cr>", "Toggle blame lines"},
          }

          wk.register({
            g = {
              name = "+gitsigns", -- Optional group name
              gitsigns_bindings
            }
          }, { prefix = "<leader>" })





          require("nvim-tree").setup({
            sort = {
              sorter = "case_sensitive",
            },
            view = {
              width = 30,
            },
            renderer = {
              group_empty = true,
            },
            filters = {
              dotfiles = true,
            },
          })






          -- Import telescope
          local telescope = require('telescope')
          local actions = require('telescope.actions')

          -- Setup telescope with more detailed configurations
          telescope.setup {
            defaults = {
              -- General settings
              prompt_prefix = "> ",
              selection_caret = "> ",
              path_display = {"smart"},

              -- Set file_ignore_patterns for ignoring specific files
              file_ignore_patterns = {"node_modules", ".git"},

              -- Layout configurations
              layout_strategy = 'horizontal',
              layout_config = {
                horizontal = {
                  mirror = false,
                  preview_width = 0.6,
                },
                vertical = {
                  mirror = false,
                },
              },

              -- Sorting and filtering settings
              sorting_strategy = "descending",
              color_devicons = true,

              -- More settings can be configured here
              mappings = {
                  i = {
                    -- Insert mode mappings
                    ["<C-j>"] = actions.move_selection_next,       -- Move selection down
                    ["<C-k>"] = actions.move_selection_previous,   -- Move selection up
                    ["<C-n>"] = actions.cycle_history_next,        -- Next history item
                    ["<C-p>"] = actions.cycle_history_prev,        -- Previous history item
                    ["<esc>"] = actions.close,                     -- Close the popup
                    -- Additional insert mode mappings
                  },
                  n = {
                    -- Normal mode mappings
                    ["j"] = actions.move_selection_next,           -- Move selection down
                    ["k"] = actions.move_selection_previous,       -- Move selection up
                    ["<esc>"] = actions.close,                     -- Close the popup
                    -- Additional normal mode mappings
                  },
              },
            },
            pickers = {
              -- Configure specific pickers
              find_files = {
                theme = "dropdown",
                previewer = false,
              },
              live_grep = {
                theme = "ivy",
              },
              buffers = {
                sort_lastused = true,
                theme = "dropdown",
                previewer = false,
                mappings = {
                  i = {
                    ["<c-d>"] = "delete_buffer",
                  },
                  n = {
                    ["<c-d>"] = "delete_buffer",
                  },
                },
              },
              -- More pickers can be configured here
            },
            extensions = {
              -- Telescope extensions can be added here
            }
          }

          -- Key mappings for telescope
          vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
          vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})
          vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true, silent = true})
          vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true, silent = true})















          -- Setup language servers.
          local lspconfig = require('lspconfig')
          lspconfig.pyright.setup {}
          lspconfig.tsserver.setup {}
          lspconfig.rust_analyzer.setup {
            -- Server-specific settings. See `:help lspconfig-setup`
            settings = {
              ['rust-analyzer'] = {},
            },
          }


          -- Global mappings.
          -- See `:help vim.diagnostic.*` for documentation on any of the below functions
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
          vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

          -- Use LspAttach autocommand to only map the following keys
          -- after the language server attaches to the current buffer
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
              -- Enable completion triggered by <c-x><c-o>
              vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

              -- Buffer local mappings.
              -- See `:help vim.lsp.*` for documentation on any of the below functions
              local opts = { buffer = ev.buf }
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
              vim.keymap.set('n', '<C-i>', vim.lsp.buf.signature_help, opts)
              vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
              vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
              vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, opts)
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set({ 'n', 'v' }, '<space>ci', vim.lsp.buf.code_action, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
              end, opts)
            end,
          })











          local cmp = require'cmp'

          cmp.setup({
            snippet = {
              -- REQUIRED - you must specify a snippet engine
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              end,
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'vsnip' }, -- For vsnip users.
              -- { name = 'luasnip' }, -- For luasnip users.
              -- { name = 'ultisnips' }, -- For ultisnips users.
              -- { name = 'snippy' }, -- For snippy users.
            }, {
              { name = 'buffer' },
            })
          })

          -- Set configuration for specific filetype.
          cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
              { name = 'buffer' },
            })
          })

          -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          })

          -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            }, {
              { name = 'cmdline' }
            })
          })

          -- Set up lspconfig.
          local capabilities = require('cmp_nvim_lsp').default_capabilities()






          local pid = vim.fn.getpid()
          -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
          local omnisharp_bin = "/run/current-system/sw/bin/OmniSharp"
          -- on Windows
          -- local omnisharp_bin = "/run/current-system/sw/bin/OmniSharp"

          local config = {
            handlers = {
              ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) },
            -- rest of your settings
            capabilities = capabilities,

            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            enable_editorconfig_support = true,

            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            enable_ms_build_load_projects_on_demand = false,

            -- Enables support for roslyn analyzers, code fixes and rulesets.
            enable_roslyn_analyzers = true,

            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            organize_imports_on_format = true,

            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            enable_import_completion = true,

            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            sdk_include_prereleases = true,

            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            analyze_open_documents_only = false,
          }

          lspconfig.omnisharp.setup(config)




          local dap = require('dap')

          dap.adapters.netcoredbg = {
            type = 'executable',
            command = '/run/current-system/sw/bin/netcoredbg',
            args = {'--interpreter=vscode'}
          }


          local dap, dapui = require("dap"), require("dapui")

          dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            mappings = {
              -- Use a table to apply multiple mappings
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
              toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
              -- Example:
              -- stacks = {
              --   open = "<CR>",
              --   expand = "o",
              -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
              {
                elements = {
                -- Elements can be strings or table with id and size keys.
                  { id = "scopes", size = 0.25 },
                  "breakpoints",
                  "stacks",
                  "watches",
                },
                size = 40, -- 40 columns
                position = "left",
              },
              {
                elements = {
                  "repl",
                  "console",
                },
                size = 0.25, -- 25% of total lines
                position = "bottom",
              },
            },
            controls = {
              -- Requires Neovim nightly (or 0.8 when released)
              enabled = true,
              -- Display controls in this element
              element = "repl",
              icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "↻",
                terminate = "□",
              },
            },
            floating = {
              max_height = nil, -- These can be integers or a float between 0 and 1.
              max_width = nil, -- Floats will be treated as percentage of your screen.
              border = "single", -- Border style. Can be "single", "double" or "rounded"
              mappings = {
                close = { "q", "<Esc>" },
              },
            },
            windows = { indent = 1 },
            render = {
              max_type_length = nil, -- Can be integer or nil.
              max_value_lines = 100, -- Can be integer or nil.
            }
          })

          local dap, dapui = require("dap"), require("dapui")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end






          vim.opt.runtimepath:append("/Users/magnus/Documents/private/parser")

          require'nvim-treesitter.configs'.setup {

            parser_install_dir = "/Users/magnus/Documents/private/parser",

            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = { "c_sharp", "c", "lua", "vim", "vimdoc", "query" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = true,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            -- List of parsers to ignore installing (or "all")
            ignore_install = { "javascript" },

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
              enable = true,

              -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
              -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
              -- the name of the parser)
              -- list of language that will be disabled
              disable = { "c", "rust" },
              -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
              disable = function(lang, buf)
                  local max_filesize = 100 * 1024 -- 100 KB
                  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                  if ok and stats and stats.size > max_filesize then
                      return true
                  end
              end,

              -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
              -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
              -- Using this option may slow down your editor, and you may see some duplicate highlights.
              -- Instead of true it can also be a list of languages
              additional_vim_regex_highlighting = false,



            },
          }






          require("neotest").setup({
            adapters = {
              require("neotest-dotnet")({
                    -- Extra arguments for nvim-dap configuration
                    -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                    dap = { justMyCode = false },
                    -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
                    -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
                    custom_attributes = {
                      xunit = { "MyCustomFactAttribute" },
                      nunit = { "MyCustomTestAttribute" },
                      mstest = { "MyCustomTestMethodAttribute" }
                    },
                    -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
                    dotnet_additional_args = {
                      "--verbosity detailed"
                    },
                    -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
                    -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
                    --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
                    discovery_root = "solution" -- Default
                  })
            },
            diagnostics = {
                enabled = true,  -- Ensure diagnostics are enabled
                -- You can customize other aspects of diagnostics here
              },
          })






          vim.cmd[[colorscheme tokyonight]]
        '';

        #fix
        coc = {
          enable = true;
          settings = builtins.fromJSON (builtins.readFile ./coc-settings.json);
        };

      };

      zsh = {
        enable = true;
        history = {
          size = 102400;
          save = 102400;
          ignoreDups = true;
          ignoreAllDups = true;
          share = true;
        };
        syntaxHighlighting = {
          enable = true;
        };
        enableAutosuggestions = true;
        oh-my-zsh = {
          enable = true;
          theme = "ys";
          plugins = [ "tmux" "fzf" "dotnet" ];
        };
      };
    };
  };

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

}
