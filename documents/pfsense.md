# pfsense

## default password
pfsense

## edit config file
```
$ vi /conf/config.xml
$ viconfig
```


/etc/rc.reload_all

Shows the current state table	pfctl -ss
Shows current filter rules	pfctl -sr
Show as much as possible.	pfctl -sa
Shows current NAT rules	pfctl -sn
Activate the pf packet filter – enables all fw functions	pfctl -e
Deactivate the pf packet filter – disables all fw functions	pfctl -d

/etc/rc.restart_webgui


PPPoE WAN setup
Your WAN should look like:

		<wan>
			<if>pppoe0</if>
			<descr><![CDATA[WAN]]></descr>
			<blockpriv></blockpriv>
			<blockbogons></blockbogons>
			<enable></enable>
			<ipaddr>pppoe</ipaddr>
		</wan>
And you'll need a PPP section like:

<ppps>
  <ppp>
    <ptpid>0</ptpid>
			<type>pppoe</type>
			<if>pppoe0</if>
			<ports>re0</ports>
			<username><![CDATA[username@qwest.net]]></username>
			<password>![CDATA[base64-password]]></password>
			<descr><![CDATA[WAN]]></descr>
			<provider>Your_ISP</provider>
		</ppp>
	</ppps>

