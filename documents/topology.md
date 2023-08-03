￼Copy code
  +------------------------+
  |  CenturyLink DSL Modem |
  |   (Fiber connection)   |
  +-----------+------------+
              |
              | WAN Port (PPPoE, VLAN 201)
              |
  +-----------v-----------+
  |    pfSense VM         |
  |   Firewall and DHCP   |
  |   VLAN 10 (LAN)       |
  |   VLAN 20 (LAN)       |
  +-----------+-----------+
              |
              | LAN Port (Trunk for VLANs 10 & 20)
  +-----------v-----------+
  |   Proxmox Server      |
  +-----------+-----------+
              |
              | Trunk Port (to TP Link Smart Switch)
  +-----------v-----------+
  |   TP Smart Switch     |
  |   VLAN 10 (Trunk)     |
  |   VLAN 20 (Trunk)     |
  +-----------+-----------+
              |
              | Port 3 (Access Port)
  +-----------v-----------+
  |   Office Dumb Switch  |
  |   VLAN 10 (Access)    |
  +-----------+-----------+
              |
              | Port 7 (Access Port)
  +-----------v-----------+
  |   TP Link Smart Switch     |
  |   VLAN 20 (Wireless Access Point)    |
  +-----------+-----------+
              |
              | Port 1
  +-----------v-----------+
  |    DD-WRT (AP)        |
  |    2.4 GHz            |
  |    5 GHz              |
  +-----------------------+
