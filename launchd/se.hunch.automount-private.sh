#!/bin/sh
for n in /Volumes/*/.private.sparseimage; do
  if [ "$(hdiutil info | grep '$n')" == "" ]; then
    open "$n"
  fi
done