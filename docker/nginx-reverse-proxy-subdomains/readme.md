## command line for basic auth
```
echo -n 'username:somepassword' | base64
```

## check for debug enabled
```
  nginx -V 2>&1 | grep -- '--with-debug'
```
