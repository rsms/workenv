#!/bin/sh
mkdir -p /Volumes/hal
/usr/bin/sshfs hal:/ /Volumes/hal -f -o reconnect,transform_symlinks,idmap=user,jail_symlinks,volname=hal
