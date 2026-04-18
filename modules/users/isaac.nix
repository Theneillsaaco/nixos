{ pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" "tty" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}