# namecheap

```
Login to your Namecheap account.
navigate to Domain List -> Domain -> Manage -> Advanced DNS
-Under "Host Records", click "Add New Record"
-Type = "A + Dynamic DNS Record"
-Host = create a hostname that you'll use here and in PfSense under "host" field. (e.g. "whatever")
-Set the value to "127.0.0.1"
-Click Save
```

Within PfSense,
Where it says "hostname" use the same name (e.g. "whatever") that you just setup on NameCheap's website. 


Login to your Namecheap account.
navigate to the advanced dns menu

https://ap.www.namecheap.com/Domains/DomainControlPanel/brianhenning.me/advancedns

Toggle ON/OFF, DYNAMIC DNS status
copy the Dynamic DNS Password
