#!/bin/sh
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
chmod +x "$DIR/VOIDRUNNER"
exec "$DIR/VOIDRUNNER" "$@"
