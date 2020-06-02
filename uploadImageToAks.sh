# Check if script is running as root
bash ./validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Resource group
RESURCE_GROUP=Infra_Core_SYD

# Azure container registry (within resource group)
REGISTRY=kloudaks01

# Azure kubernetes (AKS) cluster
CLUSTER=sanakscluster01

IMAGE=azure-vote-front:v2

# Login to the wanted container registry
az acr login --name $REGISTRY

# Login to the wanted cluster
az aks get-credentials –name $CLUSTER –resource-group $RESURCE_GROUP

# List images in repository
printf "\n\n\n\n\nImages in repository:\n"
repository list –name $REGISTRY –output table

#az acr import –name $REGISTRY –source mcr.microsoft.com/azuredocs/$IMAGE –image $IMAGE

docker push $REGISTRY.azurecr.io/$IMAGE
