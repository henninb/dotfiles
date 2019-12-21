# jq commands - JSON

## parse JSON file
```shell
$ cat json_in/chase_kari.json| jq '. | map([.guid, .description, .amount]|join(","))'
```
