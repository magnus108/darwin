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
            excludesfile = ''
              *~
              .*.swp
              .DS_Store
            '';
            autocrlf = "input";
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
        ];

        extraLuaConfig = ''
          -- Which-key configuration
          require("which-key").setup {
            -- Your configuration comes here:
            -- or leave it empty to use the default settings
            -- Refer to the documentation to see all available options
          }

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

          require'lspconfig'.omnisharp.setup(config)

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
