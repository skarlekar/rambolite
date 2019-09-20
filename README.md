# rambolite
Framework to rapidly onboard microservices on a Kubernetes cluster

## Installing the client tools
Install *cfssl* and *kubectl* and verify the installation using:

    ./scripts/install_client_tools_mac.run_locally.sh

CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates.  More about *cfssl* at [https://github.com/cloudflare/cfssl](https://github.com/cloudflare/cfssl). 

The Kubernetes command-line tool, [kubectl](https://kubernetes.io/docs/user-guide/kubectl/), allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs. For a complete list of kubectl operations, see [Overview of kubectl](https://kubernetes.io/docs/reference/kubectl/overview/).


## Initialize compute nodes on AWS
Create five EC2 instances on AWS using the Ubuntu 16.04 AMI (ami-0cfee17793b08a293).  There will be two controller instances, one load balancer and two worker nodes in our cluster as shown in the following diagram:

![Cluster Architecture](https://github.com/skarlekar/rambolite/blob/master/images/Cluster-architecture.png)



Each instance should at least be a t2.medium with 8GB memory and the following inbound rules in the security group:
![Security Group Inbound Rules](https://github.com/skarlekar/rambolite/blob/master/images/inbound-rules.png)

The following ports show allow traffic from everywhere. TCP: 80, 8888, 8080, 22 & 443.
Also allow all traffic from within your security group to allow the nodes and the controller to communicate with each other. Enable public IP for all instances. Enable all traffic from your laptop. You can use http://whatsmyip.com to find your local router's gateway IP address.

## Initalize the environment variables
Edit the scripts/0_set_environment_vars.sh and replace the public DNS name, public IP and private IP for the controllers, workers and the load balancer from your AWS console.

    vi scripts/0_set_environment_vars.sh

## Install and provision a local certificate authority
In order to generate certificates for the local kubectl to communicate with the controllers and the nodes within the Kubernetes cluster to communicate with each other, generate the certificate authority

    scripts/1_gen_cert_auth.sh

## Generate client certificates
Generate client certificates used by : `admin`, `kubelet` (one for each worker node), `kube-controller-manager`, `kube-proxy`, and `kube-scheduler`

    scripts/2_gen_admin_client_cert.sh

## Generate server certificate
Generate a server certificate `kubernetes-key.pem` and `kubernetes.pem` signed with all of the hostnames and IPs that may be used later in order to access the Kubernetes API.

 







<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk4Nzc0NTkwMyw0MzMzNzA1NiwxNzE3Nz
U0MTU2LC05MTQwMzE2NjIsLTI4MjE5ODgwLC01NzI2MjQ2MTld
fQ==
-->