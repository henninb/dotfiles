 wrangler secret put JWT_KEY

 wrangler kv:namespace create "MY_KV"

curl -X POST https://bhenning.com/api/login

curl -X POST -H "Content-Type: application/json" -d '{ "email": "henninb@gmail.com", "password": "monday1" }' http://127.0.0.1:8787
curl -X POST -H "Content-Type: application/json" -d '{ "email": "henninb@gmail.com", "password": "monday1" }' https://cflare.bhenning.com/api/login
