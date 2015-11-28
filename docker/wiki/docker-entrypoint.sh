#!/bin/bash
# Based on https://raw.githubusercontent.com/synctree/docker-mediawiki/master/1.24/docker-entrypoint.sh

# Use the original script again when we take the actual mediawiki
# source with extensions from our own git with submodules and want the
# volume to contain only images and LocalSettings.php.

set -e

chown -R www-data: .

exec "$@"
