# Install kube-dns 
kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml

# Verify that the kube-dns pod starts up correctly:
kubectl get pods -l k8s-app=kube-dns -n kube-system

# Test kube-dns using BusyBox
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

# Run an nslookup from inside the busybox container:
kubectl exec -ti $POD_NAME -- nslookup kubernetes

# Cleanup
kubectl delete deployment busybox
