# jq commands

## parse JSON file
```shell
$ cat json_in/chase_kari.json| jq '. | map([.guid, .description, .amount]|join(","))'
```

## part and remove quotes
```shell
$ cat json_in/chase_kari.json| jq -r '. | map([.guid, .description, .amount]|join(","))'
```
