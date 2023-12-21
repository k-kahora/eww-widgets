
{
  description = "A very basic flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (nixpkgs) lib;
  in
  {
    packages.x86_64-linux.mk-package = pkgs.stdenv.mkDerivation {
      name = "wall-button";
      # builder = ./builder.sh;
      nativeBuildInputs = [ pkgs.makeWrapper ];
      src = ./.;
      buildPhase = ''
      echo "... this is my custom build phase"
      echo "... nothing is done here"
      '';
      installPhase = ''
      echo "... this is my custom install phase"
      mkdir -p $out/bin
      cp wall-button $out/bin
      chmod +x $out/bin/wall-button
      cp justfile $out/bin
      cp -r Button $out/bin
      cp -r art $out/bin
      cp eww.scss $out/bin
      cp eww.yuck $out/bin
      cp magic.sh $out/bin
        wrapProgram $out/bin/wall-button \
        --suffix PATH : ${lib.makeBinPath [ pkgs.just pkgs.swww pkgs.eww ]}
      '';
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.mk-package;
  };
}