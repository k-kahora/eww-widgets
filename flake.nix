{
  description = "web flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # Do precise filtering of files in the nix store
    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs = { self, nixpkgs, flake-utils, nix-filter}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib;
      in
      {
      devShells = {
        default = pkgs.mkShell {
          packages = [
	    pkgs.eww-wayland
	    pkgs.just
	    pkgs.swww
          ];
	  shellHook = ''
	  export XDG_CONFIG_HOME="/home/malcolm/.config/"
          '';
        };

       };
     }
    );
}
