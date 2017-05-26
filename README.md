# asdf-postgis

PostGIS plugin for [asdf](https://github.com/asdf-vm/asdf) version manager

## Dependencies
_This requires [brew](http://brew.sh) if you're on a mac, or a debian flavored linux.  If you need it to work on something else, you'll likely need to modify the plugin._
You will also need a working install of PostgreSQL. See [asdf-postgres](https://github.com/smashedtoatoms/asdf-postgres) for the asdf plugin.

1. You will need a compiler.
  * Mac
    1. ```gcc```
    1. Hit the ok button and it will install.  If it already has it, then you are good.
  * Ubuntu
    1. ```sudo apt-get install linux-headers-$(uname -r) build-essential```
1. On Ubuntu, you will need libreadline
  1. ```sudo apt-get install libreadline-dev```

## Install

```
asdf plugin-add postgis https://github.com/francois/asdf-postgis.git
```

## ASDF options

Check [asdf](https://github.com/asdf-vm/asdf) readme for instructions on how to install & manage versions of Postgres.

When installing PostGIS using `asdf install`, you can pass custom configure options with the following env vars:

* `POSTGIS_CONFIGURE_OPTIONS` - use only your configure options
* `POSTGIS_EXTRA_CONFIGURE_OPTIONS` - append these configure options along with ones that this plugin already uses

# How to use (easier version)
## Install
1. Create your .tool-versions file in the project that needs PostGIS and add `postgis 2.3.2` or whatever version that you want.
2. run `asdf install`

## Install in your DB
1. Connect to your DB: `psql default` (or whatever name you gave your DB)
2. `CREATE EXTENSION postgis;`

## Stop
1. Just `DROP EXTENSION postgis`
