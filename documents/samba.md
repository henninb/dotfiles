smbclient '\\\192.168.10.20\public' -U henninb


  groupadd smbshare
   37  /sbin/groupadd smbshare
   38  /sbin/usermod -aG smbshare henninb
   39  /sbin/useradd -M -s /sbin/nologin sambauser
   40  smbpasswd -a henninb
   41  smbpasswd -e henninb
   42  testparm
