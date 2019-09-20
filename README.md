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


TCP: 80, 8888, 8080, 22 & 443 from everywhere
All traffic from within your security group to allow the nodes and the controller to communicate


Enable public IP for all instances.
 




<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg2NjE0MTk1Myw0MzMzNzA1NiwxNzE3Nz
U0MTU2LC05MTQwMzE2NjIsLTI4MjE5ODgwLC01NzI2MjQ2MTld
fQ==
-->