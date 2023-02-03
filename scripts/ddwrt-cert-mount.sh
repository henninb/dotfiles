#!/bin/sh

if [ `nvram get https_enable` -gt 0 ] ; then
	# get the absolute directory of the executable
	SELF_PATH=$(cd -P "$(dirname "$0")" && pwd -P)
	echo SELF_PATH: ${SELF_PATH}

	# extract the mount path
	MOUNT_PATH=`echo ${SELF_PATH//startup/}`
	echo MOUNT_PATH: ${MOUNT_PATH}

	# do binds
	for BIND_PATH in ${MOUNT_PATH} ; do
		 echo Binding ${BIND_PATH}
		 if [ "${MOUNT_PATH}" != "${BIND_PATH}" ]; then
					grep -q -e "${BIND_PATH}" /proc/mounts || mount -o bind ${MOUNT_PATH}${BIND_PATH} ${BIND_PATH}
		 fi
	done

	HTTPS_RESET=0

	if [ `pidof httpd` -gt 0 ]; then
		echo Stopping httpd
		stopservice httpd
		HTTPS_RESET=1
	fi

	echo Binding HTTPS certificate
	grep -q -e "/etc/cert.pem" /proc/mounts || mount -o bind ${MOUNT_PATH}/etc/cert.pem /etc/cert.pem
	grep -q -e "/etc/key.pem" /proc/mounts || mount -o bind ${MOUNT_PATH}/etc/key.pem /etc/key.pem

	if [ "$HTTPS_RESET" = "1" ]; then
		echo Starting httpd
		startservice httpd
		unset HTTPS_RESET
	fi
fi
