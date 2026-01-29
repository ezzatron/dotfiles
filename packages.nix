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
  pkgs.ffmpeg
  pkgs.gh
  pkgs.git
  (pkgs.writeShellScriptBin "gsed" "exec -a $0 ${pkgs.gnused}/bin/sed \"\$@\"")
  pkgs.go
  pkgs.go-task
  pkgs.golangci-lint
  (pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ])
  pkgs.jq
  pkgs.kubectl
  pkgs.kubectx
  pkgs.kubernetes-helm
  pkgs.kustomize
  pkgs.ngrok
  pkgs.nixfmt # To format .nix files
  pkgs.nodejs_24
  pkgs.powershell
  pkgs.protobuf
  pkgs.step-cli
  pkgs.terraform
  pkgs.unixtools.watch
  pkgs.vale
  pkgs.woff2
  pkgs.yq-go
  pkgs.zsh-history-substring-search
]
