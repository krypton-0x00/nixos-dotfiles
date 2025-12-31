{ config, pkgs, ... }:

{
  home.username = "zazzu";
  home.homeDirectory = "/home/zazzu";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles";
    };

  };
  programs.firefox = {
    enable = true;

    profiles.zazzu = {
      id = 0;
      name = "zazzu";

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "krypton-0x00";
        email = "shakirgulzar0x00@gmail.com";
      };

      github = {
        user = "krypton-0x00";
      };
    };

    extraConfig = {
      credential.helper = "libsecret";
    };
  };

  xdg.enable = true;

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/hypr";
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/nvim";
    recursive = true;
  };

  xdg.configFile."kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/kitty";
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/rofi";
    recursive = true;
  };

  xdg.configFile."swaync" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/swaync";
    recursive = true;
  };

  xdg.configFile."dunst" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/dunst";
    recursive = true;
  };

  xdg.configFile."tmux" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/tmux";
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/waybar";
    recursive = true;
  };

  xdg.configFile."cava" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/cava";
    recursive = true;
  };

  # Firefox
  xdg.configFile."firefox/zazzu/chrome" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/zazzu/nixos-dotfiles/config/firefox/chrome";
    recursive = true;
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gh
    waypaper
    swww
    gcc

    jdk17

    # ---- LSP servers ----
    clang-tools # C / C++ (clangd)
    rust-analyzer # Rust
    nil # Nix LSP (nil)
    nixd # optional alternative Nix LSP

    # ---- Formatters ----
    rustfmt # Rust
    nixpkgs-fmt # Nix formatter

    tree-sitter

    kitty
    waybar
    dunst
    rofi
    nautilus
    vesktop
    firefox
    obsidian
    btop

    hyprpaper
    hypridle
    hyprlock
    hyprpicker

    cava

    wl-clipboard
    cliphist

    grim
    slurp
    grimblast

    pamixer
    playerctl

    brightnessctl

    xdg-utils
    procps
    glib

  ];

}
