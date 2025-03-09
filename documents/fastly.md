## delete a service by name
```
fastly service delete --service-name test
fastly service delete --service-name test-vcl
```


## create a service by name
```
fastly service create --type vcl --name test
fastly service create --type wasm --name test
```


## rename a service
```
fastly service update --service-id 5pF3RbQQ9gmoziJsJCloEP --name site6
```


## curl to test
```
curl -svo /dev/null hsite1.brianhenning.click
```
