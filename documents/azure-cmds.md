# azure commands

## install az cli

## login
```
az login
```

## show resouce group
```
az group show --name brians-resource-group --output table
```

## set a subscription
```
az account list --output table
az account set --subscription <subscription-id>
```

## create a resource group
```
az group create --name centralUSResourceGroup --location centralus --output table
az group show --name brians-resource-group --output table
```

## create a storage group
```
az storage account create --name bhcentralstorageaccount --resource-group centralUSResourceGroup --location centralus --sku Standard_LRS --output table
```

## create a functional app
```
az functionapp create --consumption-plan-location eastus --name bh-test-funcapp --os-type Linux --resource-group  brians-resource-group --runtime node --runtime-version 18 --storage-account briansstorageaccunt
```

## settings for a functional app
```
az functionapp config appsettings set --name bh-myfunction-app --resource-group brians-resource-group --settings COOKIE_SECRET=123
az functionapp config appsettings list --name bh-myfunction-app --resource-group brians-resource-group --output table
```

## publish a function app
```
func init bh-myfunction-app --worker-runtime node
func azure functionapp publish bh-myfunction-app
```
## create a ruleset
```
az afd rule-set create --resource-group centralUSResourceGroup --rule-set-name ruleset1 --profile-name bh-front-door --output table
az afd rule-set list --resource-group centralUSResourceGroup --profile-name bh-front-door --output table
```

## front door create
```
az afd profile create --profile-name bhfd -g centralUSResourceGroup --sku Standard_AzureFrontDoor --output table
```

## front door endpoint hostname
```
az afd endpoint create --profile-name bhfd --resource-group centralUSResourceGroup --output table --name juiceshop --endpoint-name juiceshop
az afd endpoint list --profile-name bh-front-door --resource-group centralUSResourceGroup --output table
```

## front door list
```
az afd profile list --output table
```

## list front door origin-group
```
az afd origin-group list --resource-group centralUSResourceGroup --profile-name  bh-front-door --output table
```

## create a front door origin group
az afd origin-group create -g centralUSResourceGroup --origin-group-name HSClient --profile-name bh-front-door --probe-request-type GET --probe-protocol Http --probe-interval-in-seconds 120 --sample-size 4 --successful-samples-required 3 --additional-latency-in-milliseconds 50 --output table

az afd origin-group create -g centralUSResourceGroup --origin-group-name HSEnforcer --profile-name bh-front-door --probe-request-type GET --probe-protocol Http --probe-interval-in-seconds 120 --sample-size 4 --successful-samples-required 3 --additional-latency-in-milliseconds 50 --output table

az afd origin-group create -g centralUSResourceGroup --origin-group-name HSCollector --profile-name bh-front-door --probe-request-type GET --probe-protocol Http --probe-interval-in-seconds 120 --sample-size 4 --successful-samples-required 3 --additional-latency-in-milliseconds 50 --output table

az afd origin-group create -g centralUSResourceGroup --origin-group-name HSCaptcha --profile-name bh-front-door --probe-request-type GET --probe-protocol Http --probe-interval-in-seconds 120 --sample-size 4 --successful-samples-required 3 --additional-latency-in-milliseconds 50 --output table

## Create an origin
az afd origin create --resource-group centralUSResourceGroup --origin-group-name HSClient --profile-name bh-front-door --host-name client.perimeterx.net --http-port 80 --https-port 443 --origin-name HSClient --name HSClient --weight 1000 --priority 1 --origin-host-header client.perimeterx.net --output table

az afd origin create --resource-group centralUSResourceGroup --origin-group-name HSEnforcer --profile-name bh-front-door --host-name client.perimeterx.net --http-port 80 --https-port 443 --origin-name HSEnforcer --name HSEnforcer --weight 1000 --priority 1 --origin-host-header client.perimeterx.net --output table

## create a front door rule-set rule
az afd rule create \
    --resource-group centralUSResourceGroup --rule-set-name ruleset1  --profile-name bh-front-door \
    --order 1 \
    --match-variable UrlPath \
    --operator BeginsWith \
    --match-values '/jJ0cYtn9/' \
    --rule-name HSFirstPartyHeaders \
    --action-name ModifyRequestHeader \
    --header-action Append \
    --header-name 'x-px-first-party' \
    --header-value '1' \
    --match-processing-behavior Continue \
    --output table

az afd rule action add \
    --resource-group centralUSResourceGroup --rule-set-name ruleset1  --profile-name bh-front-door \
    --rule-name HSFirstPartyHeaders \
    --action-name ModifyRequestHeader \
    --header-action Append \
    --header-name 'x-px-enforcer-true-ip' \
    --header-value '{client_ip}' \
    --output table

az afd rule create \
    --resource-group centralUSResourceGroup --rule-set-name ruleset1  --profile-name bh-front-door \
    --order 2 \
    --match-variable UrlPath \
    --operator BeginsWith \
    --match-values '/jJ0cYtn9/init.js' \
    --rule-name HSFirstPartyClient \
    --action-name UrlRewrite \
    --source-pattern '/jJ0cYtn9/init.js' \
    --destination '/jJ0cYtn9/main.min.js' \
    --preserve-unmatched-path No \
    --match-processing-behavior Stop \
    --output table

az afd rule action add \
    --resource-group centralUSResourceGroup --rule-set-name ruleset1  --profile-name bh-front-door \
    --rule-name HSFirstPartyClient \
    --action-name RouteConfigurationOverride \
    --origin-group HSClient \
    --forwarding-protocol MatchRequest \
    --output table


az afd rule create \
    --resource-group centralUSResourceGroup --rule-set-name ruleset1  --profile-name bh-front-door \
    --order 3 \
    --match-variable UrlPath \
    --operator BeginsWith \
    --match-values '/jJ0cYtn9/captcha' \
    --rule-name HSFirstPartyCaptcha \
    --action-name UrlRewrite \
    --source-pattern '/jJ0cYtn9/captcha' \
    --destination '/PXjJ0cYtn9/' \
    --preserve-unmatched-path Yes \
    --match-processing-behavior Stop \
    --output table

az afd rule action add \
    --resource-group centralUSResourceGroup --rule-set-name ruleset1  --profile-name bh-front-door \
    --rule-name HSFirstPartyCaptcha \
    --action-name RouteConfigurationOverride \
    --origin-group HSCaptcha \
    --forwarding-protocol MatchRequest \
    --output table
