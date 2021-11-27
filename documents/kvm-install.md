# kvm setup
Easiest way to assign NICs to the guest is to leave them unconfigured in the host, and use macvtap passthrough mode for the guest NICs. Mind you, without additional, more complex settings, this will block VM live migration.

Settings:

```
  <devices>
    ...
    <interface type='direct'>
      <source dev='eth0' mode='private'/>
    </interface>
  </devices>
```

Or you can go for a full PCI-passthrough mode (provided you have IOMMU/VT-d):
```
  <devices>
    <interface type='hostdev'>
      <source>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
      </source>
      <mac address='52:54:00:6d:90:02'>
    </interface>
  </devices>
```

PCI-passthrough mode: and provided your VM has suitable driver support for the NIC
