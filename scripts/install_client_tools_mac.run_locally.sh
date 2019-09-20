# Install cfssl
# CFSSL is CloudFlare's PKI/TLS swiss army knife. It is both a command line tool and an HTTP API server for signing, verifying, and bundling TLS certificates.
# More at: https://github.com/cloudflare/cfssl
#
brew install cfssl

# verification
cfssl version
cfssljson --version

# Install kubectl
# The kubectl command line utility is used to interact with the Kubernetes API Server. 
#
curl -o kubectl https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/darwin/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# verification
kubectl version --client
