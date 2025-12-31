{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #thunar
  programs.dconf.enable = true;
  programs.thunar.enable = true;

  xdg.mime.defaultApplications = {
    "inode/directory" = "thunar.desktop";
  };

  systemd.user.services.swww = {
    description = "Wayland wallpaper daemon";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swww}/bin/swww init";
      Restart = "on-failure";
    };
  };

  #NVIDIA
  # Graphics stack
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # NVIDIA proprietary driver
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.gnome.gnome-keyring.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.zazzu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    bibata-cursors
    vulkan-tools
    mesa-demos
    nvidia-vaapi-driver
    libva

    #THUNAR
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin

    # Dependencies Thunar EXPECTS
    xfce.exo
    xfce.tumbler
    gvfs

    glib
    gsettings-desktop-schemas
    dconf

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  #ENABLE FLAKES
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";

}
