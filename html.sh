#!/bin/bash
set -eu -o pipefail
cd "$(dirname "$0")"
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
        mandoc -T html -O 'style=/mandoc.css,man=../%S/%N/' \
            "$rel" >"html/.newpage"
        mv -f "html/.newpage" "$hpagefile"
    done
}
section 3
section 7
test -L manpages || ln -s src manpages
gosh -r 7 -I . -m manpages.html-index src/html-index.sld
curl --location --fail --silent --show-error -o html/schemeorg.css \
    https://www.staging.scheme.org/schemeorg.css
cat html/schemeorg.css html-mandoc.css >html/mandoc.css
