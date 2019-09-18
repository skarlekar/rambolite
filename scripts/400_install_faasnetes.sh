# Cloning faas-netes locally
echo Cloning faas-netes locally
git clone https://github.com/openfaas/faas-netes

# Installing namespaces: openfaas & openfaas-fn on Kubernetes
echo Installing namespaces: openfaas and openfaas-fn on Kubernetes
kubectl apply -f faas-netes/namespaces.yml

# Display all the namespaces in the clusters
kubectl get namespace
# echo You should see the namespaces openfaas and openfaas-fn

# generate a random password
PASSWORD=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)

kubectl -n openfaas create secret generic basic-auth \
--from-literal=basic-auth-user=admin \
--from-literal=basic-auth-password="$PASSWORD"

# Deploy OpenFaas on Kubernetes
kubectl apply -f faas-netes/yaml
