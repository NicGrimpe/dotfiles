{ 
  config, 
  pkgs,
  ...
}:

{
  home = {
    stateVersion = "23.05";

    packages = with pkgs; [
      bat
      git
      toybox
      rnix-lsp
      pavucontrol
      cargo
      eza
      nix-bisect
      python3

      (writeShellScriptBin "cleanup" ''
        nix-collect-garbage -d --delete-older-than 30d
      '')
      (writeShellScriptBin "fix-display" ''
        xrandr --output HDMI-0 --rotate normal --output DP-1 --rotate left
      '')
    ];


    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      # EDITOR = "nvim";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
    ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
      l = "eza -l";
      fix-keyboard= "setxkbmap -model pc105 -layout us,ca -variant dvorak -option grp:win_space_toggle";
      cat = "bat -p";
    };
    initExtra = ''
      export NIX_PATH=$NIX_PATH:nicpkgs=/home/nic/src/nixpkgs

      # See ANSI Escape Sequences
      principal='\[\e[0;38;5;162m\]'
      secondary='\[\e[0;38;5;165m\]'
      accent='\[\e[0;38;5;105m\]'

      export PS1="$principal\u\[\e[0m\]$secondary@\[\e[0m\]$principal\H\[\e[0m\]$accent[\[\e[0m\]$secondary\w\[\e[0m\]$accent]\[\e[0m\] \[\e[0m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\n\[\e[0m\]$accent>\[\e[0m\] \[\e[0m\]"
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      lualine-nvim
      gruvbox-material
      vimwiki
      nvim-web-devicons
      nvim-tree-lua
      nvim-dap
    ];
  };

  programs.home-manager = {
    enable = true;
  };
}
