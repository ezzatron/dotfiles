{ pkgs, ... }:
[
  pkgs.adrs
  pkgs.buf
  pkgs.bun
  pkgs.caddy
  pkgs.clang-tools # To format .proto files
  pkgs.deno
  pkgs.evans
  pkgs.ffmpeg
  pkgs.gh
  pkgs.git
  pkgs.go
  pkgs.go-task
  pkgs.golangci-lint
  pkgs.jq
  pkgs.kubectl
  pkgs.kubectx
  pkgs.kubernetes-helm
  pkgs.kustomize
  pkgs.nixfmt # To format .nix files
  pkgs.nodejs_24
  pkgs.protobuf
  pkgs.terraform
  pkgs.unixtools.watch
  pkgs.vale
  pkgs.yq-go
  pkgs.zsh-history-substring-search
]
