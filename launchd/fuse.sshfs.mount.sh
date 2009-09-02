#!/bin/sh
# See http://code.google.com/p/macfuse/wiki/OPTIONS for options
mkdir -p /Volumes/hal
/opt/local/bin/sshfs \
	hal.hunch.se:/ \
	/Volumes/hal -f \
	-o reconnect,compression=yes \
	-o idmap=user,transform_symlinks,jail_symlinks,noappledouble \
	-o volname=hal,fsid=1337
	#-o iconpath=$HOME/Library/Scripts/some.icon
/sbin/umount -f /Volumes/hal
