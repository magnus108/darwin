{ config, pkgs, ... }:

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
      neovim
      #openlens
      ripgrep
      dotnet-sdk_7
      fzf
      git
      zip
      unzip
      tig
      gh
      docker
      jetbrains.rider
      zsh
      telepresence2
      kubectl
      nixpkgs-fmt
      nil
      nodePackages.vscode-json-languageserver
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
        InitialKeyRepeat = 1;
        KeyRepeat = 1;
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
      package = pkgs.skhd;
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
      package = pkgs.yabai;
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

        focus_follows_mouse = "autofocus";
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

  home-manager.users.magnus = {
    home = { stateVersion = "22.05"; };

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

      kitty = {
        enable = true;
        theme = "Monokai Pro";
        darwinLaunchOptions = [ "--single-instance" "--directory=~" ];
        settings = {
          scrollback_lines = 10000;
          enable_audio_bell = false;
          update_check_interval = 0;
          hide_window_decorations = "titlebar-only";
        };
        font.size = 11;
        font.name = "FiraCode Nerd Font Bold";
      };

      tmux = {
        enable = true;
        historyLimit = 10240;
        mouse = true;
        keyMode = "vi";
        newSession = true;
        terminal = "screen-256color";
        shortcut = "a";
        extraConfig = ''
          set -g status off
        '';
      };

      git = {
        enable = true;
        userName = "Magnus Møller";
        userEmail = "magnus108@me.com";
        lfs.enable = true;
        extraConfig = {
          core.autocrlf = "input";
          color.ut = "auto";
          branch.autoSetupRebase = "always";
          push.default = "simple";
          pull.rebase = "merges";
          rerere.enabled = true;
          rebase.abbreviateCommands = true;
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
        };
      };

      neovim = {
        enable = true;
        viAlias = true;
        extraConfig = builtins.readFile ./vimrc.vim;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
        withPython3 = true;
        plugins = with pkgs.vimPlugins; [ vim-nix fzf-vim haskell-vim coc-nvim ];

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
          expireDuplicatesFirst = true;
          share = true;
        };
        syntaxHighlighting.enable = true;
        enableAutosuggestions = true;
        oh-my-zsh = {
          enable = true;
          theme = "ys";
          plugins = [ "tmux" "git" "sudo" "tig" "fzf" ];
          extraConfig = ''
            ZSH_TMUX_AUTOSTART=true
          '';
        };
      };
    };
  };

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

}
