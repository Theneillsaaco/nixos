{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    openssl
    curl
    stdenv.cc.cc
  ];
}