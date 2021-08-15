# pfsense

## edit config file
vi /conf/config.xml

viconfig


/etc/rc.reload_all

Shows the current state table	pfctl -ss
Shows current filter rules	pfctl -sr
Show as much as possible.	pfctl -sa
Shows current NAT rules	pfctl -sn
Activate the pf packet filter – enables all fw functions	pfctl -e
Deactivate the pf packet filter – disables all fw functions	pfctl -d

/etc/rc.restart_webgui
