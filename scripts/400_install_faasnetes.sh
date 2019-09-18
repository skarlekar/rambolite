# Cloning faas-netes locally
echo Cloning faas-netes locally
git clone https://github.com/openfaas/faas-netes

# Installing namespaces: openfaas & openfaas-fn on Kubernetes
echo Installing namespaces: openfaas and openfaas-fn on Kubernetes
kubectl apply -f faas-netes/namespaces.yml

# Display all the namespaces in the clusters
kubectl get namespace
# echo You should see the namespaces openfaas and openfaas-fn

# Deploy OpenFaas on Kubernetes
cd faas-netes && kubectl apply -f ./yaml

