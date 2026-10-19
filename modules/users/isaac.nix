{ pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" "tty" "docker" ];
    shell = pkgs.zsh;
  };
}
