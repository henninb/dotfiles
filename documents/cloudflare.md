# cloudflare
calculate.henninb406.workers.dev

## change your nameserver (from namecheap to cloudflare)

login to cloudflare and add a site
navigate to the overview page
the dns servers will be listed there

login to namecheap account
remove namecheaphosting.com

navigate to manage -> domain

under nameservers select custom DNS

custom DNS
```
dimitris.ns.cloudflare.com
izabella.ns.cloudflare.com
```
click save to complete
this change may take up to 24 hours



## remove site from cloudflare
Click into the Overview page
on the bottom right there will be an advanced section
click on remove site from cloudflare

## heroku DNS on cloudflare
Move over to Heroku. 
Select app, go to the Settings, scroll down to add domain. 
Add both non www and www domain versions. 
Each should produce different DNS target (alias): somethingreallyobscureandcomplex098080-980809.herokudns.com 54

Move to Cloudflare DNS section and add two CNAME records. 
One is going to be www linking to the heroku DNS target for the www address, the other one is going to be non www version like yourdomain.com 3 linking to the other DNS target.

DONE

I would recommend you also read this article and do both steps as a bare minimum:

https://www.viget.com

Heroku + Cloudflare: The Right Way | Viget 513
You might be missing out on these security steps when using Cloudflare with Heroku.

https://www.viget.com/articles/heroku-Cloudflare-the-right-way/
