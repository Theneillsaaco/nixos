{
  programs.starship = {
    enable = true;

    settings = {
      scan_timeout = 3000;
      add_newline = false;
    
      format = ''
        $cmd_duration$directory$git_branch
        $character''
      ;

      character = {
        success_symbol = "[ ](bold bright-yellow)";
        error_symbol = "[ ](bold red)";
      };

      package.disabled = true;

      cmd_duration = {
        min_time = 0;
        format = "[](bright-black)[󰪢 $duration](bold fg:white bg:bright-black)[](bright-black) ";
      };

      directory = {
        home_symbol = " ";
        read_only = "  ";
        style = "fg:black bg:blue bold";
        truncation_length = 2;
        truncation_symbol = ".../";
        format = "[](blue)[󰉋 → $path]($style)[](blue)";

        substitutions = {
          "Desktop" = "  ";
          "Documents" = "  ";
          "Downloads" = "  ";
          "Music" = " 󰎈 ";
          "Pictures" = "  ";
          "Videos" = "  ";
          "GitHub" = " 󰊤 ";
        };
      };

      git_branch = {
        style = "fg:black bg:purple bold";
        symbol = "󰘬";
        truncation_length = 12;
        truncation_symbol = "";
        format = " 󰜥 [](purple)[$symbol $branch(:$remote_branch)]($style)[](purple) ";
      };

      git_commit = {
        commit_hash_length = 4;
        tag_symbol = " ";
      };

      git_state = {
        format = "([$state($progress_current of $progress_total)])($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };

      git_status = {
        conflicted = " 🏳 ";
        ahead = " 🏎💨 ";
        behind = " 😰 ";
        diverged = " 😵 ";
        untracked = " 🤷 ";
        stashed = " 📦 ";
        modified = " 📝 ";
        staged = "[++($count)](italic green)";
        renamed = " ✍️ ";
        deleted = " 🗑 ";
      };

      memory_usage.disabled = true;
      time.disabled = true;

      username = {
        style_user = "bold fg:black bg:bright-yellow";
        style_root = "bold fg:white bg:red";
        format = "[](bright-yellow)[$user]($style)[](bright-yellow) ";
        disabled = true;
      };

      hostname = {
        ssh_only = false;
        format = "[•$hostname](bold fg:black bg:bright-yellow)[](bright-yellow) ";
        trim_at = ".companyname.com";
        disabled = true;
      };
    };
  };
}
