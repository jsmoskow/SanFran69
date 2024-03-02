#!/bin/sh
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD$

# PROVIDE: dropbear
# REQUIRE: LOGIN
# KEYWORD: shutdown

name="dropbear"
command="/usr/local/bin/${name}"
pidfile="/var/run/${name}.pid"
rcvar="${name}_enable"

rc_start() {
	# Make sure all process are stopped
	rc_stop

	# Start dropbear
	/usr/sbin/dropbear -R

}

rc_stop() {	
	# Terminate dropbear process if found
	pidnum="$(/bin/pgrep $name)"
	if [ -n "${pidnum}" ]; then
		/usr/bin/killall $name
		echo "dropbear stopped (${pidnum})"
	fi
}

rc_status() {	
	# Check status and print pid if running
	pidnum="$(/bin/pgrep $name)"
	if [ -n "${pidnum}" ]; then
		echo "dropbear is running (${pidnum})"
	else
		echo "dropbear is not running"
	fi
}

if [ $# -eq 0 ]; then
	echo "no parameter specified - starting dropbear"
	rc_start
	exit
fi

case $1 in
	start)
		rc_start
		;;
	stop)
		rc_stop
		;;
	restart)
		rc_stop
		rc_start
		;;
	status)
		rc_status
		;;
esac
