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

## Generate Kubeconfigs for the cluster components & distribute
A **kubeconfig** file is a file used to configure access to Kubernetes when used in conjunction with the kubectl commandline tool (or other clients). Generate kubeconfig files for the various components in the cluster: `kubelet`, `kube-proxy`, `kube-controller-manager`, `kube-scheduler,` and one for the `admin` user.

    scripts/10_gen_kubeconfig.sh
    scripts/11_move_kubeconfigs.sh

## Generate Data Encryption Config & distribute to the Controllers
To store sensitive data as secrets, create a data encryption config containing an encryption key.

    scripts/12_gen_encryption_key.sh
    scripts/13_move_encryption_key.sh

## Build a **etcd** Cluster on each of the Controllers
_etcd_ is a strongly consistent, distributed key-value store that provides a reliable way to store data that needs to be accessed by a distributed system or cluster of machines. It gracefully handles leader elections during network partitions and can tolerate machine failure, even in the leader node.

Build an *etcd* cluster across your Kubernetes control nodes.

    scripts/14_install_etcd_on_controllers.sh

## Install Control Plane on the Controllers
Install the binaries for `kube-apiserver`, `kube-controller-manager`, k`ube-scheduler`,  and `kubectl` on the controllers.

    scripts/15_install_control_plane_on_controllers.sh

## Setup the Kubernetes API Server on the Controllers
To interact with Kubernetes you will be using the Kubernetes API server. Configure `kube-apiserver` service on the controllers.

    scripts/16_install_kubernetes_api.sh

## Setup the Kubernetes Controller Manager on the Controllers
In Kubernetes the Controller Manager is a daemon uses a **control** loop that watches the shared state of the cluster through the `kube-apiserver` and makes changes attempting to move the current state towards the desired state (ie., it brings up the worker nodes if it fails). Configure the `kube-controller-manager` service on the controllers.

    scripts/17_setup_kube_controller_manager.sh

## Setup the Kubernetes Scheduler on the Controllers
The Kubernetes Scheduler controls performance, capacity and availability of the worker nodes through policies and topology awareness. The Kubernetes scheduler attempts to match each Pod created by Kubernetes to a suitable set of resources on a Node. It can also distribute copies of Pods across different Nodes for high availability, if that feature is desired. If it fails to find hardware that suits a Pod's requirements and specifications, that Pod is left unscheduled, and the scheduler retries it until a machine becomes available. Configure the `kube-scheduler` on the controllers.

    scripts/18_setup_kube_scheduler.sh

## Enable HTTP Health Checks for the Controllers
Enable HTTP health checks using nginx. Install nginx on each controller, configure and start it.

    scripts/19_enable_health_checks.sh

## Setup RBAC the Controllers
Kubernetes uses **R**ole-**B**ased **A**ccess **C**ontrol configuration to allow the cluster's API to access `kubelet` functionality such as logs and metrics. Configure RBAC for `kubelet` authorization

    scripts/20_setup_rbac.sh

## Setup a Kube API Load Balancer
To achieve high availability for the Kubernetes API server we have setup two controller nodes running API Server services in each one of them. To perform load balancing between them setup a nginx server to perform the load balancing among these services.

    scripts/21_config_load_balancer.sh

## Install Services on Workers

Download and install the binaries worker nodes services, `kubectl`, `kube-proxy`, `kubelet` and configure them.

    scripts/22_intall_worker_binaries.sh

## Configure Container Runtime on the Workers
`Containerd` is the container runtime used to run containers managed by Kubernetes. Configure `containerd` on both of our worker node servers.

    scripts/23_configure_containerd.sh

## Configure Kubernetes Agent on the Workers
`kubelet` is the Kubernetes agent which runs on each worker node. Acting as a middleman between the Kubernetes control plane and the underlying container runtime, it coordinates the running of containers on the worker node. Configure `kubelet` on each of the worker nodes.

    scripts/24_configure_kubelet.sh

## Configure Network Routing on the Workers
`kube-proxy` is responsible for providing network routing to support Kubernetes networking components. Configure kube-proxy on each of the worker nodes and start all the worker node binaries: 
`containerd`, `kubelet`,  and  `kube-proxy`

    scripts/25_configure_kubeproxy.sh

## Enable Networking in the Kubernetes Cluster
For pods to communicate with each other and rest of the eco-system in Kubernetes, you will need to setup a network. **Weave Net** creates a virtual network that connects  containers across multiple hosts and enables their automatic discovery; ie., it provides a network to connect all pods together, implementing the **Kubernetes** model where every Pod gets its own IP address. **Kubernetes** uses the Container Network Interface (CNI) to join pods onto **Weave Net**. 

    scripts/26_enable_ip_forwarding_in_workers.sh
    scripts/27_install_weave_net.sh

## Configure Remote Access
Configure `kubectl` to allow running commands against your remote Kubernetes cluster.

In a separate shell, open up an ssh tunnel to port 6443 on your Kubernetes API load balancer using:

    scripts/100_start_ssh_tunnel_to_lb.run_locally.sh

Back in the main shell where you were your setting up your cluster, run the following command to setup a new cluster, configure the credentials of the admin user in the cluster and set the current context to the new cluster.

    scripts/101_create_kube_cluster_and_context.sh
    scripts/102_test_install_kube_dns.run_locally.sh

## Testing the Kubernetes Installation

Verify that the cluster is setup correctly and working fully as expected by running some basic tests.
**Have the secondary shell with the ssh tunnel to the load-balancer active for all the tests**

### Test Remote Access & Networking
Test the remote access by creating a web-server service with replicas of  `nginx` and pinging it with a `curl` command from another container running `busybox`

    scripts/200_test_kubernetes.run_locally.sh
    scripts/201_clean_up_test_200.run_locally.sh






<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2NzQ3MTUzMDIsNjE4NjE1ODgxLDM4MD
I2NjM3MCwxNTc0NzMzNTE4LC0xOTEzNjkxMTM1LC05ODc3NDU5
MDMsNDMzMzcwNTYsMTcxNzc1NDE1NiwtOTE0MDMxNjYyLC0yOD
IxOTg4MCwtNTcyNjI0NjE5XX0=
-->