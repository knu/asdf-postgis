#!/usr/bin/env bash

set -euo pipefail

plugin_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
mkdir -p "$plugin_dir/.tmp"
test_dir=$(mktemp -d "$plugin_dir/.tmp/gdal-min.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT
mkdir -p "$test_dir/raster/rt_pg"
source_file="$test_dir/raster/rt_pg/rtpg_geometry.c"

cat >"$source_file" <<'SOURCE'
/* surrounding code */
	/* MIN macro is from GDAL's cpl_port.h */
	num_bands = MIN(pixtypes_len, values_len);
	num_bands = MIN(num_bands, nodatavals_len);
/* trailing code */
SOURCE
cat >"$test_dir/expected" <<'SOURCE'
/* surrounding code */
	num_bands = Min(pixtypes_len, values_len);
	num_bands = Min(num_bands, nodatavals_len);
/* trailing code */
SOURCE

bash "$plugin_dir/lib/patch-gdal-min.bash" "$test_dir"
cmp "$test_dir/expected" "$source_file"
bash "$plugin_dir/lib/patch-gdal-min.bash" "$test_dir"
cmp "$test_dir/expected" "$source_file"

# A different implementation must fail instead of silently applying a partial fix.
printf '\tnum_bands = MIN(other_len, values_len);\n' >"$source_file"
if bash "$plugin_dir/lib/patch-gdal-min.bash" "$test_dir" >"$test_dir/failure.log" 2>&1; then
    printf '%s\n' 'Expected an incompatible source to fail' >&2
    exit 1
fi

rm "$source_file"
bash "$plugin_dir/lib/patch-gdal-min.bash" "$test_dir"
printf '%s\n' 'GDAL compatibility patch checks passed'
