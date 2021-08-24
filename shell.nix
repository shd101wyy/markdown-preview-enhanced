let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in pkgs.mkShell { buildInputs = with pkgs; [ nodejs-14_x yarn ]; }
