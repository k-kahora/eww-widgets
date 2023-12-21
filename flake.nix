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
	  buildPhase = ''
	  mkdir -p $out/bin
	  out_saved=$out
	  echo "eww open example --config $out_saved/bin"  >> runner.sh
	  echo "echo failure"  >> runner.sh
	  '';
	  
	  installPhase = ''
	  cp $src/justfile $out/bin
	  cp $src/eww.scss $out/bin
	  cp -r $src/art $out/bin
	  cp $src/eww.yuck $out/bin
	  # cp $src/runner.sh $out/bin
	  cp -r $src/Button $out/bin
	  cp $src/magic.sh $out/bin
	  cp runner.sh $out/bin
 	  '';

        };
        my-script = (pkgs.writeScriptBin my-name (builtins.readFile ./runner.sh)).overrideAttrs(old: {

          buildCommand = "${old.buildCommand}\n patchShebangs $out";

        });
      in
      {
        packages = {
	  
          my-script = 
          let 
	    wow = "wow";

	    scriptor = pkgs.writeShellScriptBin my-name ''
	    out_saved=$out
	    echo $out_saved
	    echo $out
	    eww open example --config $out_saved/bin

	    '';
	    in pkgs.symlinkJoin {
	    src = self;
	    name = my-name;
	    paths = [build] ++ [scriptor] ++ [pkgs.swww pkgs.just pkgs.eww-wayland];
	    buildInputs = [pkgs.makeWrapper];
	    # TODO Build phase is not doing anything 
	    # The directory is not gettin created
	    # result does not contain these files
            postBuild = ''
 	    wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin
	    echo 
	    '';
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
