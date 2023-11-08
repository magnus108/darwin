{ config, pkgs, ... }:

{

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
            dotnet-sdk
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
        ];
    };

  nixpkgs.config = { allowUnfree = true; };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      font-awesome
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  home-manager.users.magnus = {
    home = {
      stateVersion = "22.05";
    };

    programs = {

        noti.enable = true;
        navi.enable = true;

        kitty = {
            enable = true;
            theme = "Monokai Pro";
            darwinLaunchOptions = [
                "--single-instance"
                "--directory=~"
            ];
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
                mergetool.vimdiff.cmd = "nvim -d $LOCAL $MERGED $BASE $REMOTE -c 'wincmd w' -c 'wincmd j'";
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
            plugins = with pkgs.vimPlugins; [
                vim-nix
                haskell-vim
                coc-nvim
            ];

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
                plugins = [
                    "git"
                    "sudo"
                    "tig"
                ];
            };
      };
    };
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;


  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
