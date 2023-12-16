#!/bin/sh

# Ensure that the hello.sh script is executable
# chmod +x $src/hello.sh
source $stdenv/setup
mkdir -p $out/bin
cp $src/justfile $out/bin
cp -r $src/Button $out/bin
cp -r $src/eww.yuck $out/bin
cp -r $src/eww.scss $out/bin
cp -r $src/magic.sh $out/bin
# Run the hello.sh script

cat >$out/bin/hello <<EOF
#!$SHELL
eww open --config ./
EOF

chmod +x $out/bin/hello
