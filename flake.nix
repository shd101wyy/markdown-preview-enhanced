{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unstableNixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      unstableNixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        unstablePkgs = import unstableNixpkgs { inherit system; };
      in
      {
        devShell = import ./shell.nix {
          inherit pkgs;
          inherit unstablePkgs;
        };
      }
    );
}
