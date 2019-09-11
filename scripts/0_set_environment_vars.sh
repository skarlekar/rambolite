export SCRIPTS_DIR=./scripts
export SSH_ID_FILE=~/k8s.pem

export CONTROLLER0_HOST=ec2-18-208-195-208.compute-1.amazonaws.com
export CONTROLLER0_IP=192.168.0.40
export CONTROLLER1_HOST=ec2-34-201-4-157.compute-1.amazonaws.com
export CONTROLLER1_IP=192.168.0.44
export WORKER0_HOST=ec2-18-233-200-213.compute-1.amazonaws.com
export WORKER0_IP=192.168.0.47
export WORKER1_HOST=ec2-34-237-141-115.compute-1.amazonaws.com
export WORKER1_IP=192.168.0.85
export LB_HOST=ec2-34-235-150-91.compute-1.amazonaws.com
export LB_IP=192.168.0.11
export CERT_HOSTNAME=10.32.0.1,$CONTROLLER0_IP,$CONTROLLER0_HOST,$CONTROLLER1_IP,$CONTROLLER1_HOST,$LB_IP,$LB_HOST,127.0.0.1,localhost,kubernetes.default

# Set KUBERNETES_ADDRESS=<load balancer private ip>
export KUBERNETES_ADDRESS=$LB_IP
