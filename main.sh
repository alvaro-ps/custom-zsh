#!/bin/bash
###
# Include the path of this file in the .bashrc
###

basepath=$(cd $(dirname "$0") && pwd)

# source the aliases file
source $basepath"/init.sh"

# source the aliases file
source $basepath"/aliases.sh"

# iterate over the apps folder and init all the apps
# that have an init script
appspath=$basepath"/apps/"
for folder in $(ls $appspath); do
    initscript=$appspath$folder"/init.sh"
    if [ -e $initscript ]; then
        source $initscript
    fi
done
