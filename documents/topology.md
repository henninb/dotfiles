￼Copy code
  +-----------------------+
  |  CenturyLink DSL Modem |
  |   (Fiber connection)   |
  +-----------+-----------+
              |
              | WAN Port (PPPoE)
              |
  +-----------v-----------+
  |    pfSense VM        |
  |   VLAN 10 (LAN)      |
  |   VLAN 20 (LAN)      |
  +-----------+-----------+
              |
              | LAN Port (Trunk for VLANs)
  +-----------v-----------+
  |   Proxmox Server     |
  +-----------+-----------+
              |
              | Trunk (to TP Smart Switch)
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
  |   TP Smart Switch     |
  |   VLAN 20 (Access)    |
  +-----------+-----------+
              |
              | Port 1
  +-----------v-----------+
  |    DD-WRT (AP)        |
  |  Firewall & DHCP     |
  +-----------------------+
