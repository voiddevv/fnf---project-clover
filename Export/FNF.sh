#!/bin/sh
echo -ne '\033c\033]0;FNF\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/FNF.x86_64" "$@"
