{ pkgs, ... }: {
  home.packages = with pkgs; [
    (discord.overrideAttrs (old: {
      version = "0.0.130";
      src = pkgs.fetchurl {
        url = "https://dl.discordapp.net/apps/linux/0.0.130/discord-0.0.130.tar.gz";
        sha256 = "sha256-FMIM/CWPk3Kcqp8iIg+gxiCpjD2DNk7dSBqnCBvzn5w=";
      };
    }))
    brave
    steam
    pear-desktop
    onlyoffice-desktopeditors
  ];
}