{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$shlvl$directory$git_branch$git_commit$git_state$git_metrics$git_status$line_break$character";
      right_format = "$status$cmd_duration$time";

      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
      };

      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
      };

      shlvl = {
        disabled = false;
        symbol = "󰄷 ";
        style = "bold red";
      };

      status = {
        disabled = false;
        symbol = "✘ ";
        format = "[$symbol$common_meaning$signal_name$maybe_int]($style) ";
      };

      time = {
        disabled = false;
      };
    };
  };
}
