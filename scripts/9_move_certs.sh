scp -i $SSH_ID_FILE ca.pem $WORKER0_HOST-key.pem $WORKER0_HOST.pem ubuntu@$WORKER0_HOST:~/
scp -i $SSH_ID_FILE ca.pem $WORKER1_HOST-key.pem $WORKER1_HOST.pem ubuntu@$WORKER1_HOST:~/
scp -i $SSH_ID_FILE ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem service-account-key.pem service-account.pem ubuntu@$CONTROLLER0_HOST:~/
scp -i $SSH_ID_FILE ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem service-account-key.pem service-account.pem ubuntu@$CONTROLLER1_HOST:~/
