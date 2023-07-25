{
  description = "A very basic flake";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pg-db-dev = "dev";
        pg-db-test = "test";
      in {
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              nodejs-18_x
              elmPackages.elm
              elmPackages.elm-format
              nodePackages.cordova
              android-studio
            ];
            shellHook = ''
              ROOT_DIR=$(git rev-parse --show-toplevel)
              export PATH=$ROOT_DIR/node_modules/.bin:$PATH
            '';
          };

      });
}
