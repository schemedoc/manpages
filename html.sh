#!/bin/bash
set -eu -o pipefail
mkdir -p html
find html -mindepth 1 -delete
section() {
    sec="$1"
    dir="man$sec"
    ext="${sec}scheme"
    hsecdir="html/$sec"
    mkdir "$hsecdir"
    for rel in $(find "$dir" -type f -name "*.$ext" | sort); do
        page=$(basename "$rel" | sed "s@\\.$ext\$@@")
        hpagedir="$hsecdir/$page"
        hpagefile="$hpagedir/index.html"
        echo "$hpagefile"
        mkdir -p "$hpagedir"
        mandoc -T html "$rel" >"html/.newpage"
        mv -f "html/.newpage" "$hpagefile"
    done
}
section 3
section 7
