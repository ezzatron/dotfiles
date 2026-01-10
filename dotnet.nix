{ pkgs, ... }:
pkgs.dotnetCorePackages.combinePackages [
  pkgs.dotnetCorePackages.dotnet_8.sdk
  pkgs.dotnetCorePackages.dotnet_9.sdk
]
