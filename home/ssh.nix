{ config, ... }:
{
  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    file.sshAllowedSigners = {
      enable = true;
      force = true;
      source = ./ssh-allowed-signers;
      target = ".ssh/allowed_signers";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      IdentityAgent "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
