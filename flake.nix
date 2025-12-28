{
  description = "Quarto development environment (R, Python, LaTeX)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            quarto
            python3
            R
            rPackages.reticulate
            texliveFull
          ];

          shellHook = ''
            export RETICULATE_PYTHON=${pkgs.python3}/bin/python3
          '';
        };
      }
    );
}
