#!/bin/bash

source /run/secrets/*

echo "Building cache"
/usr/bin/liquidsoap --cache-only "$@"

echo "Execing liquidsoap"
exec /usr/bin/liquidsoap "$@"