#!/usr/bin/env bash


mkdir -p ~/.config/opencode/

basepath=$(cd $(dirname "$0") && pwd)

ln -f "${basepath}/AGENTS.md" ~/.config/opencode/AGENTS.md

export OPENCODE_CONFIG="${basepath}/opencode.json"
