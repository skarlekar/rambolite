# Run Grafana in OpenFaaS Kubernetes namespace:

kubectl -n openfaas run \
--image=stefanprodan/faas-grafana:4.6.3 \
--port=3000 \
grafana

# Expose Grafana with a NodePort:

kubectl -n openfaas expose deployment grafana \
--type=NodePort \
--name=grafana

# Find Grafana node port address:

GRAFANA_PORT=$(kubectl -n openfaas get svc grafana -o jsonpath="{.spec.ports[0].nodePort}")
GRAFANA_URL=http://IP_ADDRESS:$GRAFANA_PORT/dashboard/db/openfaas

kubectl port-forward deployment/grafana 3000:3000 -n openfaas &
