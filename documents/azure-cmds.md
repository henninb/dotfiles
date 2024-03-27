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
az group create --name centralUSResourceGroup --location centralus
az group show --name brians-resource-group --output table
```

## create a storage group
```
az storage account create --name bhcentralstorageaccount --resource-group centralUSResourceGroup --location centralus --sku Standard_LRS
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
