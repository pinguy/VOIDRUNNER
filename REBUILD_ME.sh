#!/bin/sh
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$DIR" && OUT="$DIR/VOIDRUNNER" exec sh ./build_gcc9_bullseye.sh VOIDRUNNER.c
