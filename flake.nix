{
  description = "web flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs = { self, nixpkgs, flake-utils, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
	my-name = "test";
	build = pkgs.stdenv.mkDerivation {
	  src = ./.;
	  name = "wow";
	  buildInputs = [pkgs.coreutils];
	  phases = ["buildPhase"];
	  buildPhase = ''
	  mkdir -p $out/bin
	  cp $src/justfile $out/bin
	  cp $src/eww.scss $out/bin
	  cp -r $src/art $out/bin
	  cp $src/eww.yuck $out/bin
	  cp -r $src/Button $out/bin
	  '';

        };
        my-script = (pkgs.writeScriptBin my-name (builtins.readFile ./runner.sh)).overrideAttrs(old: {

          buildCommand = "${old.buildCommand}\n patchShebangs $out";

        });
      in
      {
        packages = {
          my-script = pkgs.symlinkJoin {
	    src = self;
	    name = my-name;
	    paths = [build] ++ [my-script] ++ [pkgs.swww pkgs.just pkgs.eww-wayland];
	    buildInputs = [pkgs.makeWrapper];
	    # TODO Build phase is not doing anything 
	    # The directory is not gettin created
	    # result does not contain these files
            postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";
};
        };

        defaultPackage = self.packages.${system}.my-script;

        devShell = pkgs.mkShell {
          packages = [
            pkgs.eww-wayland
            pkgs.just

            pkgs.swww
          ];
          shellHook = ''
            export XDG_CONFIG_HOME="/home/malcolm/.config/"
          '';
        };
      }
    );
}
