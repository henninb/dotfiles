#!/bin/sh

echo "curl 'https://localhost/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/'
echo "curl 'http://localhost/subdir1/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/subdir1/'
echo "curl 'http://localhost/subdir2/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/subdir2/'
