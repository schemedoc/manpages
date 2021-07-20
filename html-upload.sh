#!/bin/sh
set -eu
cd "$(dirname "$0")"
curl --location --fail --silent --show-error -o html/style.css \
    https://www.staging.scheme.org/style.css
rsync -crv html/ alpha.servers.scheme.org:/production/man/www/
