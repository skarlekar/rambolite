# rambolite
Framework to rapidly onboard microservices on a Kubernetes cluster

## Installing the Client Tools
Install *cfssl* and *kubectl* and verify the installation using:

    ./scripts/install_client_tools_mac.run_locally.sh

CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates.  More about *cfssl* at [https://github.com/cloudflare/cfssl](https://github.com/cloudflare/cfssl). 

The Kubernetes command-line tool, [kubectl](https://kubernetes.io/docs/user-guide/kubectl/), allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs. For a complete list of kubectl operations, see [Overview of kubectl](https://kubernetes.io/docs/reference/kubectl/overview/).


## Initialize Compute Nodes on AWS
Create five EC2 instances on AWS using the Ubuntu 16.04 AMI (ami-0cfee17793b08a293).  There will be two controller instances, one load balancer and two worker nodes in our cluster as shown in the following diagram:

![Cluster Architecture](https://github.com/skarlekar/rambolite/blob/master/images/Cluster-architecture.png)



Each instance should at least be a t2.medium with 8GB memory and the following inbound rules in the security group:
![Security Group Inbound Rules](https://github.com/skarlekar/rambolite/blob/master/images/inbound-rules.png)

The following ports show allow traffic from everywhere. TCP: 80, 8888, 8080, 22 & 443.
Also allow all traffic from within your security group to allow the nodes and the controller to communicate with each other. Enable public IP for all instances. Enable all traffic from your laptop. You can use http://whatsmyip.com to find your local router's gateway IP address.

## Initalize the Environment Variables
Edit the scripts/0_set_environment_vars.sh and replace the public DNS name, public IP and private IP for the controllers, workers and the load balancer from your AWS console.

    vi scripts/0_set_environment_vars.sh

## Install and provision a local Certificate Authority
In order to generate certificates for the local kubectl to communicate with the controllers and the nodes within the Kubernetes cluster to communicate with each other, generate the certificate authority

    scripts/1_gen_cert_auth.sh

## Generate Client Certificates
Generate client certificates used by : `admin`, `kubelet` (one for each worker node), `kube-controller-manager`, `kube-proxy`, and `kube-scheduler`

    scripts/2_gen_admin_client_cert.sh
    scripts/3_gen_worker_certs.sh
    scripts/4_gen_controller_manager_cert.sh
    scripts/5_gen_kube_proxy_cert.sh
    scripts/6_gen_kube_scheduler_cert.sh

## Generate Server Certificate
Generate a server certificate `kubernetes-key.pem` and `kubernetes.pem` signed with all of the hostnames and IPs that may be used later in order to access the Kubernetes API.

    scripts/7_gen_create_server_cert.sh


## Generate the Service Account Key Pair
 Kubernetes provides the ability for service accounts to authenticate using tokens. It uses a key-pair to provide signatures for those tokens. Generate the service account certificates  key-pair  files: `service-account-key.pem` and `service-account.pem`

    scripts/8_gen_service_acct_cert.sh

## Deploy the Certificates
Distribute the generated certificates to the servers on the cloud

    scripts/9_move_certs.sh

## Generate Kubeconfigs for the Cluster Components & Distribute
A **kubeconfig** file is a file used to configure access to Kubernetes when used in conjunction with the kubectl commandline tool (or other clients). Generate kubeconfig files for the various components in the cluster: `kubelet`, `kube-proxy`, `kube-controller-manager`, `kube-scheduler,` and one for the `admin` user.

    scripts/10_gen_kubeconfig.sh
    scripts/11_move_kubeconfigs.sh


    







<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyMzE5Mzg5MDYsLTE5MTM2OTExMzUsLT
k4Nzc0NTkwMyw0MzMzNzA1NiwxNzE3NzU0MTU2LC05MTQwMzE2
NjIsLTI4MjE5ODgwLC01NzI2MjQ2MTldfQ==
-->