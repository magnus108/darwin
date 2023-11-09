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
        mouse = true;
        historyLimit = 10240;
        keyMode = "vi";
        newSession = true;
        shortcut = "a";
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

  system.stateVersion = 4;
}
