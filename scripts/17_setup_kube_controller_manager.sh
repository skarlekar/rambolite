echo "Starting setup kubernetes controller manager api on controller 0"
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST 'sudo cp kube-controller-manager.kubeconfig /var/lib/kubernetes/'
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_kube_controller_manager_service.sh ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST '~/commands_gen_kube_controller_manager_service.sh'
echo "Done setting up kubernetes controller manager on controller 0"
#
#
echo "Starting setup kubernetes controller manager api on controller 1"
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST 'sudo cp kube-controller-manager.kubeconfig /var/lib/kubernetes/'
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_kube_controller_manager_service.sh ubuntu@$CONTROLLER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST '~/commands_gen_kube_controller_manager_service.sh'
echo "Done setting up kubernetes controller manager on controller 1"
