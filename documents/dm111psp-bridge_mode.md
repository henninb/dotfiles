default:
U: admin
P: password
IP: 192.168.0.1

ADSL Settings
1) change VCI 32

Basic Settings
1) Encapsulation
2) Login, password


Device Mode
1) Modem (Modem Only)

NAT settings?

I am trying to disable to router capabilities on my Netgear ADSL2+ Modem dm111psp v2 for my Centrylink DSL service.  I have changed VCI 32 to support Century Link and set the device mode to Modem (Modem Only). On my DDWRT router I have set my connection type to PPPoE and put in my username and password from Century Link. My problem is I am not getting a connection and I don't know where my problem is. I am certain the ddwrt side is setup correctly. On my Netgear do I need to disable to firewall? Should I turn of NAT? Thanks.

https://forum.dd-wrt.com/phpBB2/viewtopic.php?t=320498&highlight=dm111psp


21:11 < henninb> looking for some troubleshooting advice, my pfsense is a pppoe client and is not able to connect to my DSL Netgear modem. any logs or tools I can run to help figure out the problem?
21:13 < peerce> pppoe actually handshakes and connects with a server at the provider, not with the 'modem'
21:13 < peerce> the modem just cnoverts ethernet to DSL and back.
21:14 < peerce> now, I didn't know netgear was making pure dsl modems, I thought they made DSL modem+routers, and other sorts of routers.
21:15 < henninb> peerce, any way the modem (previously configured as a router/modem combo) would block the handshakes and connections with the service provider?
21:16 < peerce> sure, if its stil setup as some sort of router.
21:17 < peerce> what model netgear is this?
21:17 < henninb> the router portion has been disabled.
21:17 < henninb> netgear dm111psp
21:18 < peerce> https://www.netgear.com/home/products/networking/dsl-modems-routers/DM111PSP.aspx#tab-techspecs  says thats purely a modem, no routing functionality at all ?!?
21:21 < db> security  * not applicable
21:21 < db> I'm relieved lol
21:21 < henninb> it has a router capability, i changed the Device Mode to "modem only" to disable to router.
21:25 < peerce> so in modem only, does the modem still do the pppoe handshake for you, or does it expect the router behind it to do it ?
21:26 < peerce> for that matter, once its in modem only mode, how would yuou connect to the modem to check or change its configuration, since its no longering issuing DHCP nor using the 192.168 subnet ??
21:28 < henninb> peerce, my understanding is the router behind it should perform the pppoe handshake. I loose the ability to connect to the modem after I switch it over to "modem only" mode.

web GUI: Status -> System Logs, click on the tab corresponding to the log file of interest.

https://www.youtube.com/watch?v=omuklZrzopM

$ netstat -r
Routing tables

Internet:
Destination        Gateway            Flags     Netif Expire
localhost          link#4             UH          lo0
192.168.10.0/24    link#1             U          igb0
pfSense            link#1             UHS         lo0
192.168.20.0/24    link#2             U          igb1
192.168.20.1       link#2             UHS         lo0

Internet6:
Destination        Gateway            Flags     Netif Expire
localhost          link#4             UH          lo0
fe80::%igb0/64     link#1             U          igb0
fe80::21b:21ff:fe6 link#1             UHS         lo0
fe80::%igb1/64     link#2             U          igb1
fe80::21b:21ff:fe6 link#2             UHS         lo0
fe80::%lo0/64      link#4             U           lo0
fe80::1%lo0        link#4             UHS         lo0



enc0: flags=0<> metric 0 mtu 1536
	nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>
	groups: enc
