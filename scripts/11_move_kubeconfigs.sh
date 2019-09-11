#
# Move kubeconfig to the worker nodes
#
scp -i $SSH_ID_FILE $WORKER0_HOST.kubeconfig kube-proxy.kubeconfig ubuntu@$WORKER0_HOST:~/
scp -i $SSH_ID_FILE $WORKER1_HOST.kubeconfig kube-proxy.kubeconfig ubuntu@$WORKER1_HOST:~/

#
# Move kubeconfig files to the controller nodes:
#
scp -i $SSH_ID_FILE admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ubuntu@$CONTROLLER0_HOST:~/
scp -i $SSH_ID_FILE admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ubuntu@$CONTROLLER1_HOST:~/
