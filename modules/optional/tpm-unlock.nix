{ ... }: {
  # Necesario para que el token TPM2 embebido en el header LUKS2
  # se detecte y use automáticamente durante el initrd.
  boot.initrd.systemd.enable = true;

  # tpm2-tools, tpm2-abrmd y las reglas udev necesarias
  security.tpm2.enable = true;
}