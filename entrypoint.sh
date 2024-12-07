#!/bin/bash

source /run/secrets/*

exec /usr/bin/liquidsoap "$@"