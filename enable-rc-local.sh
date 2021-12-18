#!/bin/sh

### create systemd service script

cat <<___ >/lib/systemd/system/rc-local.service
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
___

### install

rm -f /etc/systemd/system/multi-user.target.wants/rc-local.service
ln -s /lib/systemd/system/rc-local.service /etc/systemd/system/multi-user.target.wants/rc-local.service
systemctl enable rc-local

###


exit 0


### create rc.local (example)

cat <<___ >/etc/rc.local
#!/bin/sh
echo Hello, world >/tmp/rc-local-test.txt
___
chmod +x /etc/rc.local

