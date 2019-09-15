COMMAND_FILE=commands_configure_kubeproxy.sh
echo "Starting configuring kubeproxy on worker 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$WORKER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER0_HOST "~/$COMMAND_FILE $WORKER0_HOST"
echo "Done configuring kubeproxy on worker 0"
#
#
echo "Starting configuring kubeproxy on worker 1"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$WORKER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER1_HOST "~/$COMMAND_FILE $WORKER1_HOST"
echo "Done configuring kubeproxy on worker 1"
