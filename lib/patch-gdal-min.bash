#!/usr/bin/env bash

set -euo pipefail

source_dir=$1
source_file="$source_dir/raster/rt_pg/rtpg_geometry.c"
plugin_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

# GDAL 3.13 renamed MIN to CPL_MIN.  Use PostgreSQL's Min as upstream does.
# https://github.com/postgis/postgis/commit/032bbd6237c705c4c5a3bc53a5e366f62e6d88ab
if [ -f "$source_file" ] && grep -Fq 'num_bands = MIN(' "$source_file"; then
    patch -f -d "$source_dir" -p1 <"$plugin_dir/patches/gdal-min.patch"
fi
