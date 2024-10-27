#!/bin/bash
if [ -z "$(ls -A -- "/usr/local/lsws/conf/")" ]; then
	cp -R /usr/local/lsws/.conf/* /usr/local/lsws/conf/
fi
if [ -z "$(ls -A -- "/usr/local/lsws/admin/conf/")" ]; then
	cp -R /usr/local/lsws/admin/.conf/* /usr/local/lsws/admin/conf/
fi
#chown 994:994 /usr/local/lsws/conf -R
#chown 994:1001 /usr/local/lsws/admin/conf -R
chown -R lsadm:lsadm /usr/local/lsws/admin/conf/htpasswd
chmod 644 /usr/local/lsws/admin/conf/htpasswd
chown -R lsadm:lsadm /usr/local/lsws/admin/conf/
chmod 755 /usr/local/lsws/admin/conf/

/usr/local/lsws/bin/lswsctrl start
$@
while true; do
	if ! /usr/local/lsws/bin/lswsctrl status | /usr/bin/grep 'litespeed is running with PID *' > /dev/null; then
		break
	fi
	sleep 60
done

