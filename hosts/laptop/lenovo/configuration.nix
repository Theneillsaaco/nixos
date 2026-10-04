# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, myLib, inputs, lib, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common.nix
      ../../../modules/optional/tpm-unlock.nix

      ../../../modules/hardware/amd.nix
      ../../../modules/users/isaac.nix
    ]
    ++ myLib.importDir ../../../modules/system
    ++ myLib.importDir ../../../modules/programs
    ++ myLib.importDir ../../../modules/services
    ++ myLib.importDir ../../../modules/desktop
    ++ myLib.importDir ../../../packages;

  security.allowUserNamespaces = true;

  boot = {
    # Resume from swap on boot
    resumeDevice = "/dev/mapper/luks-d7768ef2-4c7b-4d66-acec-96bd52f82e5b";
    kernelParams = [ "resume_offset=31237376" ];

    kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-bore-lto-x86_64-v3;
  };

  fileSystems."/nix".options = lib.mkAfter [ "compress=zstd" "noatime" ];
  
  # Dont touch this
  system.stateVersion = "26.05";
}
