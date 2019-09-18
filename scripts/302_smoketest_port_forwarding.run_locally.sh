# First, get the pod name of the nginx pod and store it an an environment variable:
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")

# Forward port 8081 to the nginx pod:
kubectl port-forward $POD_NAME 8081:80 &
BG_PID=$!
sleep 2

# Open up a new terminal on the same machine running the kubectl port-forward command and verify that the port forward works.
curl --head http://127.0.0.1:8081

# Kill the background process
kill $BG_PID
echo You should get an http 200 OK response from the nginx pod
