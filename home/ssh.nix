{ ... }:
{
  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "${user.home}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent "${user.home}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
