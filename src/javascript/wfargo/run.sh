#!/bin/sh

echo costco
# cat transactions.json| jq -r '.accountActivity | .postedTransactions | .[] | (.transactionSaleDate, ",")'
cat transactions.json| jq -r '.accountActivity | .postedTransactions | .[] | "\(.transactionSaleDate),\(.transactionDescription),\(.transactionAmount)"'

echo amex
# cat amex.json | jq -r '.transactions | .[] | "\(.charge_date),\(.description),\(.amount)"'
cat amex.json | jq -r '.transactions | .[] | "\(.charge_date),\(.extended_details.merchant.display_name),\(.amount)"'

exit 0
