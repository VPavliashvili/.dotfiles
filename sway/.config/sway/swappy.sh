#!/usr/bin/env bash

# avoid stacking lots of instances of slurp and swappy by spamming printScreen
# when screenshot is already running
if  pgrep "swappy" > /dev/null
then
    exit 1
fi

grim -g "$(slurp)" - | swappy -f -
