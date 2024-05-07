#!/bin/sh

# Set the name of your resource group
resourceGroup='DefaultResourceGroup-EUS'

# List all resources in the resource group and delete them
az resource list --resource-group $resourceGroup --query "[].id" --output tsv | while read -r resourceId
do
  echo "Deleting resource: $resourceId"
  az resource delete --ids "$resourceId" --no-wait
done

echo "All resources in resource group '$resourceGroup' have been scheduled for deletion."
