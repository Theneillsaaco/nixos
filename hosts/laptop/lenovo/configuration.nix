# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, lib, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common.nix
      
      ../../../modules/optional/tpm-unlock.nix

      ../../../modules/hardware/amd.nix
      ../../../modules/users/isaac.nix
    ];
    
  security.allowUserNamespaces = true;

  boot = {
    # Resume from swap on boot
    resumeDevice = "/dev/mapper/luks-d7768ef2-4c7b-4d66-acec-96bd52f82e5b";
    kernelParams = [ "resume_offset=31237376" ];

    kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-bore-lto-x86_64-v3;

    initrd.luks.devices."luks-d7768ef2-4c7b-4d66-acec-96bd52f82e5b" = {
      allowDiscards = true;
      bypassWorkqueues = true;
    };
  };

  fileSystems."/nix".options = lib.mkAfter [ "compress=zstd" "noatime" ];

  services = {
    # Actualizaciones de firmware vía LVFS (fwupdmgr update).
    # OJO: una actualización de firmware cambia PCR 0 y hay que re-enrolar el TPM:
    #   sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+2+7+12 /dev/disk/by-uuid/d7768ef2-4c7b-4d66-acec-96bd52f82e5b
    fwupd.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "lock";
    };
  };

  systemd.sleep.settings.Sleep.HibernateDelaySec = "45min";
  
  # Dont touch this
  system.stateVersion = "26.05";
}
