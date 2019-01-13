cat json_in/chase_kari.json| jq '. | map([.guid, .description, .amount]|join(","))'
