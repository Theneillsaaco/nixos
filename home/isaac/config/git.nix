{
  programs.git = {
    enable = true;

    ignores = [ ".direnv/" ".idea/" ];
    
    settings = {
      user = {
        name = "Theneillsaaco";
        email = "isaacdepena18@gmail.com";
      };

      init.defaultBranch = "master";

      pull.rebase = true;
      push.autoSetupRemote = true;

      rebase = {
        autosquash = true;
        autostash = true;
      };

      merge.conflictstyle = "zdiff3";
      diff.algorithm = "histogram";
      commit.verbose = true;
      help.autocorrect = "prompt";
    };
  };
}
