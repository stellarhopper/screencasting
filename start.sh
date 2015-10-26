#! /bin/bash

# To start:
# 1. In ffconnect.sh, edit INRES and FPS as desired
# 2. In ffserver.conf, edit VideoSize and VideoFrameRate to be the same
# 3. Make sure the port forwarding and firewalls are set up to allow port 8090
# 4. Run start.sh
# 5. Point a browser to http://localhost:8090/live.webm
#    (replace localhost with IP or DNS name for external access)


ffs_conf=./ffserver.conf
ff_conn=./ffconnect.sh
ffs_pid=
ff_pid=

_fail()
{
	echo "$*"
	exit 1
}

_cleanup()
{
	[ -n "$ffs_pid" ] && kill $ffs_pid
	[ -n "$ff_pid" ] && kill $ff_pid
}


[ -s $ffs_conf ] || _fail "missing $ffs_conf"
[ -s $ff_conn ] || _fail "missing $ff_conn"

if ! which ffserver 2>&1 >/dev/null; then _fail "install ffserver"; fi

ffserver -f $ffs_conf &
ffs_pid=$!

echo "Started ffserver: pid $ffs_pid"

$ff_conn
ff_pid=$!

trap _cleanup EXIT
