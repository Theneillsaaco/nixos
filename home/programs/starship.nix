{
  programs.starship = {
    enable = true;
    settings = {
      scan_timeout = 300;
      add_newline = false;
      continuation_prompt = "[▸▹ ](dimmed white)";

      format = ''
        ($nix_shell$container$fill$git_metrics)
        $cmd_duration$hostname$localip$shlvl$shell$env_var$jobs$sudo$username$character
      '';

      right_format = "$directory$git_branch$git_commit$git_state$git_status$nodejs$python$rust$golang$status$os$battery$time";

      character = {
        format = "$symbol ";
        success_symbol = "[◎](bold italic bright-yellow)";
        error_symbol = "[○](italic purple)";
        vimcmd_symbol = "[■](italic dimmed green)";
      };

      directory = {
        home_symbol = "⌂";
        truncation_length = 2;
        truncation_symbol = "□ ";
        read_only = " ◈";
        style = "italic blue";
        format = "[$path]($style)[$read_only]($read_only_style)";
      };

      git_branch = {
        format = " [$branch(:$remote_branch)]($style)";
        symbol = "[△](bold italic bright-blue)";
        style = "italic bright-blue";
        truncation_symbol = "⋯";
        truncation_length = 11;
        ignore_branches = ["main" "master"];
        only_attached = true;
      };

      git_metrics = {
        format = "([▴$added]($added_style))([▿$deleted]($deleted_style))";
        added_style = "italic dimmed green";
        deleted_style = "italic dimmed red";
        ignore_submodules = true;
        disabled = false;
      };

      time = {
        disabled = false;
        format = "[ $time]($style)";
        time_format = "%R";
        style = "italic dimmed white";
      };

      cmd_duration = {
        min_time = 0;
        format = "[◄ $duration ](italic white)";
      };
    };
  };
}