{ ... }:
{
  home = {
    file.filtersReduceSize300DPI = {
      enable = true;
      force = true;
      source = ./filters-reduce-size-300-dpi.qfilter;
      target = ".config/filters/reduce-size-300-dpi.qfilter";
    };

    activation = {
      copyFilters = ''
        mkdir -p "$HOME/Library/Filters"
        cp -f "$HOME/.config/filters/"*.qfilter "$HOME/Library/Filters/"
      '';
    };
  };
}
