{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.user.services.swww = {
    description = "Wayland wallpaper daemon";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swww}/bin/swww init";
      Restart = "on-failure";
    };
  };


  
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
   ];

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
  ];
  #ENABLE FLAKES
  nix.settings.experimental-features = [ "nix-command" "flakes"];



  system.stateVersion = "25.11"; 

}

