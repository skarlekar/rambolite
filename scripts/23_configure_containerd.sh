COMMAND_FILE=commands_config_containerd.sh
echo "Starting setup kubernetes binaries on worker 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$WORKER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER0_HOST "~/$COMMAND_FILE"
echo "Done setting up kubernetes binaries on worker 0"
#
#
echo "Starting setup kubernetes binaries on worker 1"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$WORKER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER1_HOST "~/$COMMAND_FILE"
echo "Done setting up kubernetes binaries on worker 1"
