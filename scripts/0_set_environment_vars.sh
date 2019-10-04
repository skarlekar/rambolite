export SCRIPTS_DIR=./scripts

# Path to your EC2 key.pem file
export SSH_ID_FILE=~/k8s.pem

# Host name of your controller 1
export CONTROLLER0_HOST=

# Public IP of your Controller 1
export CONTROLLER0_PUBLIC_IP=

# Private IP of your Controller 1
export CONTROLLER0_IP=192.168.0.17

# Host name of your controller 2
export CONTROLLER1_HOST=

# Public IP of your Controller 2
export CONTROLLER1_PUBLIC_IP=

# Private IP of your Controller 2
export CONTROLLER1_IP=

# Host name of your worker 1 node
export WORKER0_HOST=

# Private IP of your worker 1 node
export WORKER0_IP=

# Host name of your worker 2 node
export WORKER1_HOST=

# Private IP of your worker 2 node
export WORKER1_IP=

# Host name of your load balancer
export LB_HOST=

# Private IP of your load balancer
export LB_IP=

# Leave this as it is
export CERT_HOSTNAME=10.32.0.1,$CONTROLLER0_IP,$CONTROLLER0_HOST,$CONTROLLER1_IP,$CONTROLLER1_HOST,$LB_IP,$LB_HOST,127.0.0.1,localhost,kubernetes.default
export INITIAL_CLUSTER=$CONTROLLER0_HOST=https://$CONTROLLER0_IP:2380,$CONTROLLER1_HOST=https://$CONTROLLER1_IP:2380

# Leave this as it is
# Set KUBERNETES_ADDRESS=<load balancer private ip>
export KUBERNETES_ADDRESS=$LB_IP
