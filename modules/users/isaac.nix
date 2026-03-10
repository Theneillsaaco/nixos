{ pkgs, ... }:

{
  users.users.isaac = {
    isNormalUser = true;
    description = "Isaac";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}