sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo mkdir -p /etc/nginx/tcpconf.d
cat << EOF | sudo tee -a /etc/nginx/nginx.conf 
include /etc/nginx/tcpconf.d/*;
EOF

CONTROLLER0_IP=$1
CONTROLLER1_IP=$2

cat << EOF | sudo tee /etc/nginx/tcpconf.d/kubernetes.conf
stream {
    upstream kubernetes {
        server $CONTROLLER0_IP:6443;
        server $CONTROLLER1_IP:6443;
    }

    server {
        listen 6443;
        listen 443;
        proxy_pass kubernetes;
    }
}
EOF

sudo nginx -s reload
curl -k https://localhost:6443/version
