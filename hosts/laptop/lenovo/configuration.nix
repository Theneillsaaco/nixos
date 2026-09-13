# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, myLib, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common.nix
      ../../../modules/optional/tpm-unlock.nix

      ../../../modules/hardware/amd.nix
      ../../../modules/users/isaac.nix
    ] ++ myLib.importDir ../../../modules/system
      ++ myLib.importDir ../../../modules/programs
      ++ myLib.importDir ../../../modules/services
      ++ myLib.importDir ../../../modules/desktop
      ++ myLib.importDir ../../../packages;

  security.allowUserNamespaces = true;

  # Resume from swap on boot
  boot.resumeDevice = "/dev/mapper/luks-d7768ef2-4c7b-4d66-acec-96bd52f82e5b";
  boot.kernelParams = [ "resume_offset=31237376" ];
  
  # Dont touch this
  system.stateVersion = "26.05";
}
