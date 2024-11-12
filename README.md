# asdf-postgis

PostGIS plugin for [asdf](https://github.com/asdf-vm/asdf) version manager

## Dependencies

This requires [brew](http://brew.sh) if you're on macOS, or a Debian flavored Linux.  If you need it to work on something else, you'll likely need to modify the plugin.
According to PostGIS installation page, you will need GEOS, Proj, GDAL, LibXML2 and JSON-C.
Finally, you will need a working installation of PostgreSQL. See [asdf-postgres](https://github.com/smashedtoatoms/asdf-postgres) for the asdf plugin.

1. You will need a compiler.
  * macOS
    1. ```gcc```
    1. Hit the ok button and it will install.  If it already has it, then you are good.
  * Ubuntu
    1. ```sudo apt-get install linux-headers-$(uname -r) build-essential```
1. On Ubuntu, you will need libreadline
  1. ```sudo apt-get install libreadline-dev```
1. On macOS, you will need these dependencies installed.
  1. ```brew install geos proj gdal libxml2 json-c```

## Install

```
asdf plugin-add postgis https://github.com/francois/asdf-postgis.git
```

## ASDF options

Check [asdf](https://github.com/asdf-vm/asdf) readme for instructions on how to install & manage versions of Postgres.

When installing PostGIS using `asdf install`, you can pass custom configure options with the following env vars:

* `POSTGIS_CONFIGURE_OPTIONS` - use only your configure options
* `POSTGIS_EXTRA_CONFIGURE_OPTIONS` - append these configure options along with ones that this plugin already uses

asdf-postgis is aware of asdf-postgres and properly installs PostGIS to the currently selected PostgreSQL installation.

# How to use (easier version)
## Install
1. Create your .tool-versions file in the project that needs PostGIS and add `postgis 2.3.2` or whatever version that you want.
2. run `asdf install`

## Enable PostGIS in your DB
1. Connect to your DB: `psql default` (or whatever name you gave your DB)
2. `CREATE EXTENSION postgis;` (Ditto for `postgis_topology`, `postgis_raster`, etc. if you need them)

## Disable PostGIS in your DB
1. Just `DROP EXTENSION postgis;`

## Uninstall
1. Run `asdf uninstall postgis`.  However, this does not really uninstall PostGIS because the PostGIS runtime files are in the library directory of the PostgreSQL installation.

2. Make sure you've dropped PostGIS extensions from all databases, and locate the runtime files by the following command.

   ```sh
   find "$(pg_config --pkglibdir)" -maxdepth 1 \( -name '*postgis*' -or -name 'address_standardizer*' \)
   ```

3. If the list looks good, delete them.

   ```sh
   find "$(pg_config --pkglibdir)" -maxdepth 1 \( -name '*postgis*' -or -name 'address_standardizer*' \) -delete
   ```

## Notes

- If you want to install the same version of PostGIS to multiple PostgreSQL instances, the second attempt is blocked by `postgis X.Y.Z is already installed`.  In that case, run `asdf uninstall postgis X.Y.Z` and retry.
