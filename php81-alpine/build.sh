#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."
docker build -t netfantom/php-fpm-ru:8.1-alpine -f $SCRIPT_DIR/Dockerfile .