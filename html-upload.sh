#!/bin/sh
set -eu
cd "$(dirname "$0")"
rsync -crv html/ alpha.servers.scheme.org:/production/doc/www/man/
