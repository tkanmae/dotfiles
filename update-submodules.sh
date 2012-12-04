#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Update submodules
# ------------------------------------------------------------------------------
git submodule foreach --recursive 'git pull origin master'
# git submodule update --recursive
