#!/bin/bash

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

npm update -g $NPMLIST
npm cache clean
