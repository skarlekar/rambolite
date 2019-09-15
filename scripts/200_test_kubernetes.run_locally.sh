## First, create an Nginx deployment with 2 replicas:
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  selector:
    matchLabels:
      run: nginx
  replicas: 2
  template:
    metadata:
      labels:
        run: nginx
    spec:
      containers:
      - name: my-nginx
        image: nginx
        ports:
        - containerPort: 80
EOF

## Next, create a service for that deployment so that we can test connectivity to services as well:
kubectl expose deployment/nginx

## Now let's start up another pod. We will use this pod to test our networking. We will test whether we can connect to the other pods and services from this pod.
kubectl run busybox --image=radial/busyboxplus:curl --command -- sleep 3600
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

echo "Sleeping for 10 seconds..."
sleep 10
echo "...woke up!"

## Now let's get the IP addresses of our two Nginx pods:
echo "IP Addresses of the two Nginx pods that we just created are:"
kubectl get ep nginx

NGINX_POD1_IP=$(kubectl get ep nginx | grep nginx | awk '{print $2}' | sed "s/,/ /g" | awk '{print $1}')
NGINX_POD2_IP=$(kubectl get ep nginx | grep nginx | awk '{print $2}' | sed "s/,/ /g" | awk '{print $2}')

kubectl exec $POD_NAME -- curl $NGINX_POD1_IP
kubectl exec $POD_NAME -- curl $NGINX_POD2_IP

## Now let's verify that we can connect to services.
kubectl get svc
NGINX_SVC_IP=$(kubectl get svc | grep nginx | awk '{print $3}')
echo "IP Address of the Nginx service is: $NGINX_SVC_IP"

# Access the service from the busybox pod!
kubectl exec $POD_NAME -- curl $NGINX_SVC_IP
