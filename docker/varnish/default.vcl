vcl 4.1;

backend default {
  .host = "192.168.10.155";
  .port = "8080";
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
