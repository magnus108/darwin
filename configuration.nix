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
      dotnet-sdk_7
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
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleKeyboardUIMode = 3;
        AppleFontSmoothing = 1;
        _HIHideMenuBar = true;
      };
      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        tilesize = 40;
      };
      finder = {
        QuitMenuItem = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
    };
  };

  services = {

    spacebar = {
      enable = true;
      package = pkgs.spacebar;
    };

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
        lalt - up : yabai -m window --focus north
        lalt - down : yabai -m window --focus south
        lalt - left : yabai -m window --focus west
        lalt - right : yabai -m window --focus east

        # Swap Window
        shift + lalt - up : yabai -m window --swap north
        shift + lalt - down : yabai -m window --swap south
        shift + lalt - left : yabai -m window --swap west
        shift + lalt - right : yabai -m window --swap east

        # Resize Window
        shift + cmd - left : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
        shift + cmd - right : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0
        shift + cmd - up : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
        shift + cmd - down : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0

        # Focus Space
        ctrl - 1 : yabai -m space --focus 1
        ctrl - 2 : yabai -m space --focus 2
        ctrl - 3 : yabai -m space --focus 3
        ctrl - 4 : yabai -m space --focus 4
        ctrl - 5 : yabai -m space --focus 5
        #ctrl - left : yabai -m space --focus prev
        #ctrl - right: yabai -m space --focus next

        # Send to Space
        shift + ctrl - 1 : yabai -m window --space 1
        shift + ctrl - 2 : yabai -m window --space 2
        shift + ctrl - 3 : yabai -m window --space 3
        shift + ctrl - 4 : yabai -m window --space 4
        shift + ctrl - 5 : yabai -m window --space 5
        shift + ctrl - left : yabai -m window --space prev && yabai -m space --focus prev
        shift + ctrl - right : yabai -m window --space next && yabai -m space --focus next

        # Menu
        #cmd + space : for now its using the default keybinding to open Spotlight Search
      '';
    };

    yabai = {
      enable = true;
      package = pkgs.yabai;
      config = {
        # Extra Config
        layout = "bsp";
        auto_balance = "off";
        split_ratio = "0.50";
        window_border = "on";
        window_border_width = "2";
        window_placement = "second_child";
        focus_follows_mouse = "autoraise";
        mouse_follows_focus = "off";
        top_padding = "10";
        bottom_padding = "10";
        left_padding = "10";
        right_padding = "10";
        window_gap = "10";
      };
    };
  };

  home-manager.users.magnus = {
    home = { stateVersion = "22.05"; };

    programs = {
      gh = {
        enable = true;
        extensions = [
        ];
      };
      gh-dash = {
        enable = true;
      };


      noti.enable = true;
      navi.enable = true;

      kitty = {
        enable = true;
        theme = "Monokai Pro";
        darwinLaunchOptions = [ "--single-instance" "--directory=~" ];
      };

      tmux = {
        enable = true;
        historyLimit = 10240;
        mouse = true;
        keyMode = "vi";
        newSession = true;
        terminal = "screen-256color";
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
        plugins = with pkgs.vimPlugins; [ vim-nix haskell-vim coc-nvim ];

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
          plugins = [ "git" "sudo" "tig" ];
        };
      };
    };
  };

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

}
