vcl 4.1;

import std;

#acl purge {
#    "127.0.0.1";
#}

backend default {
  .host = "172.21.0.2";
  .port = "80";
}

sub vcl_deliver {
    # send some handy statistics back, useful for checking cache
    if (obj.hits > 0) {
        set resp.http.X-Cache-Action = "HIT";
        set resp.http.X-Cache-Hits = obj.hits;
    } else {
        set resp.http.X-Cache-Action = "MISS";
    }
}

#sub vcl_recv {
#    if ( req.request == "POST") {
#        ban("req.http.host == " + req.http.Host);
#        return(pass);
#    }
#}
