# pfsense

## defaults
username: admin
password: pfsense
LAN: 192.168.1.1/24

## edit config file
```
$ vi /conf/config.xml
$ viconfig
```

## reload config
/etc/rc.reload_all

Shows the current state table  pfctl -ss
Shows current filter rules  pfctl -sr
Show as much as possible.  pfctl -sa
Shows current NAT rules  pfctl -sn
Activate the pf packet filter – enables all fw functions  pfctl -e
Deactivate the pf packet filter – disables all fw functions  pfctl -d

/etc/rc.restart_webgui

## PPPoE WAN setup
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

## Playstation - nat type 2
```
Navigate to Firewall / NAT.
Navigate to Outbound and change the Outbound NAT Mode to Hybrid outbound NAT Rule Generation and click on Save.
```

```
click on Add to Add a new Rule next.
The Source IP is the IP of your Gaming Console. [give your console a static IP Address].
Make sure you select 32 as your subnet mask, which means that this rule ONLY applies to this one IP Address or your Gaming Console.
```

## modem web portal access
```
modem: 192.168.0.1
pfsense LAN: 192.168.10.1
wan: pppoe, on device re0

Under Interfaces > Assignments I created a new assignment re0 with static ip address 192.168.0.2/24

Configure Outbound NAT rule

Source: 192.168.10.0/24
Destination: 192.168.0.0/24

Translation box Interface Address.

3. Switch to Hybrid Outbound NAT - saved and applied settings
```

## pfsense vlan10 setup
```
ifconfig vlan10 create
ifconfig vlan10 vlan 10 vlandev em0
ifconfig vlan10 inet 192.168.10.1 netmask 255.255.255.0
```
