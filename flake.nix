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
        my-script = (pkgs.writeScriptBin my-name (builtins.readFile ./runner.sh)).overrideAttrs(old: {

          buildCommand = "${old.buildCommand}\n patchShebangs $out";

        });
      in
      {
        packages = {
          wow = pkgs.symlinkJoin {
	    src = ./.;
	    name = my-name;
	    paths = [my-script] ++ [pkgs.swww pkgs.just pkgs.eww-wayland];
	    buildInputs = [pkgs.makeWrapper];
	    buildPhase = ''
	    mkdir -p $out/tester
	    '';

            postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";

};
        };
	# apps.runit = {
	# type = "app";
	# program = "${self.packages.${system}.wow}/bin/hello.sh";

	# };

        defaultPackage = self.packages.${system}.wow;

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
