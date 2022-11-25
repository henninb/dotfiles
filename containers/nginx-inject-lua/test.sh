#!/bin/sh

echo "curl 'https://localhost/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/'
echo "curl 'https://localhost/subdir1/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/subdir1/'
echo "curl 'https://localhost/subdir2/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/subdir2/'
echo "curl 'https://localhost/site1/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/site1/'
echo "curl 'https://localhost/hello/'"
curl --cacert proxy.brianstore.xyz.crt 'https://localhost/hello/'
