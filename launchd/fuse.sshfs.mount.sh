#!/bin/sh
# See http://code.google.com/p/macfuse/wiki/OPTIONS for options
mkdir -p /Volumes/hal
/opt/local/bin/sshfs \
	hal.hunch.se:/ \
	/Volumes/hal -f -C \
	-o reconnect \
	-o idmap=user,transform_symlinks,jail_symlinks,noappledouble \
	-o volname=hal,fsid=0x1337
	#-o iconpath=$HOME/Library/Scripts/some.icon
