#!/bin/sh

# Runs the re-build switch command so I can't forget it

echo Starting switch:

if [[ `hostname` == "linda" ]]; then
    sudo nixos-rebuild switch --flake ~/nixos#linda
fi