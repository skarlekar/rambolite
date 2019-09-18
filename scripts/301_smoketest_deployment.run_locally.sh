# Create a a simple nginx deployment
kubectl run nginx --image=nginx --replicas=2 --labels="app=nginx,env=dev"

# Verify that the deployment created a pod and that the pod is running:
kubectl get pods -l app=nginx
