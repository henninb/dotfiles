## delete a service by name
fastly service delete --service-name test
fastly service delete --service-name test-vcl


## create a service by name
fastly service create --type vcl --name test
fastly service create --type wasm --name test
