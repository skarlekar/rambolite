# First, let's set an environment variable to the name of the nginx pod:
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")

# Get the logs from the nginx pod:
kubectl logs $POD_NAME

# This command should return the nginx pod's logs. It will look something like this (but there could be more lines):
# '127.0.0.1 - - [10/Sep/2018:19:29:01 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.47.0" "-"'
