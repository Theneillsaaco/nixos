{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jdk17
    jdk21
    jdk

  ];
}