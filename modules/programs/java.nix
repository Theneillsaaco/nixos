{ pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
  
  environment.systemPackages = with pkgs; [
    jdk25
    jdk21
    jdk17
  ];
}