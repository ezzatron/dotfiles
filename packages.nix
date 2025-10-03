{ pkgs, ... }:
[
  pkgs.adrs
  pkgs.bun
  pkgs.caddy
  pkgs.clang-tools # To format .proto files
  pkgs.colordiff
  pkgs.deno
  (import ./dotnet.nix { inherit pkgs; })
  pkgs.evans
  pkgs.gh
  pkgs.git
  (pkgs.writeShellScriptBin "gsed" "exec -a $0 ${pkgs.gnused}/bin/sed \"\$@\"")
  pkgs.go-task
  (pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ])
  pkgs.jq
  pkgs.kubectl
  pkgs.kubectx
  pkgs.kubernetes-helm
  pkgs.nixfmt-rfc-style # To format .nix files
  pkgs.nodejs_24
  pkgs.powershell
  pkgs.protobuf
  pkgs.terraform
  pkgs.unixtools.watch
  pkgs.vale
  pkgs.zsh-history-substring-search
]
