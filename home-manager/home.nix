{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nic";
  home.homeDirectory = "/home/nic";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
    pkgs.bat

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "cleanup" ''
      nix-collect-garbage -d --delete-older-than 30d
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nic/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  
  programs.bash = {
    enable = true;
    shellAliases = {
      l = "ls -l";
      fix-keyboard= "setxkbmap -model pc105 -layout us,ca -variant dvorak -option grp:win_space_toggle";
      cat = "bat -p";
    };
    initExtra = ''
      # See ANSI Escape Sequences
      principal='\[\e[0;38;5;82m\]'
      secondary='\[\e[0;38;5;22m\]'
      accent='\[\e[0;38;5;85m\]'

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
    ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
