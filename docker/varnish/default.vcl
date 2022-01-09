vcl 4.1;

backend default {
  .host = "192.168.10.155";
  .port = "8443";
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
