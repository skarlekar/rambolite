# First, create a service to expose the nginx deployment:
kubectl expose deployment nginx --port 80 --type NodePort
sleep 2
# Get the node port assigned to the newly-created service and assign it to an environment variable:
kubectl get svc
NGINX_SVC_IP=$(kubectl get svc | grep nginx | awk '{print $3}')
NGINX_SVC_PORT=$(kubectl get svc | grep nginx | awk '{print $5}' | sed "s/.*://g" | sed "s/\/TCP//g")
echo "IP Address of the Nginx service is: $NGINX_SVC_IP:$NGINX_SVC_PORT"

ssh -i $SSH_ID_FILE ubuntu@$WORKER0_HOST "curl -I localhost:"$NGINX_SVC_PORT
echo You should get an http 200 OK response
