#!/bin/sh

# Ensure that the hello.sh script is executable
# chmod +x $src/hello.sh
cp $src/justfile $out/bin
cp -r $src/Button $out/bin
cp -r $src/eww.yuck $out/bin
cp -r $src/eww.scss $out/bin
cp -r $src/magic.sh $out/bin
# Run the hello.sh script

