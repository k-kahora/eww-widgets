# See all envar variables in derivation 
# nix-store --read-log <derivation-path> to see the stdoutput of the build
declare -xp
# Run the below command in a nix repl with your loaded flake to take a look
# It contains a bash script to set path variables for the builder
# gives access to bash and gcc stuff as well as coreutils
# builtins.toString outputs.packages.x86_64-linux.my-packges.stdenv
source $stdenv/setup # bui


buildPhase() {
    echo "... this is my custom build phase"
    gcc foo.c -o foo
}

installPhase() {
    mkdir -p $out/bin
    cp foo $out/bin
}

genericBuild
