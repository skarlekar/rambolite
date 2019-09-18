# set an environment variable to the name of the nginx pod:
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")

# To test kubectl exec, execute a simple nginx -v command inside the nginx pod:
kubectl exec -ti $POD_NAME -- nginx -v

echo This command should return the nginx version output, which should look like this:
echo nginx version: nginx/1.17.3
