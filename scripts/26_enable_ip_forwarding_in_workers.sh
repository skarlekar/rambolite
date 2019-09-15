COMMAND_FILE=commands_enable_ip_forwarding_in_workers.sh
echo "Enabling IP forwarding in worker 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$WORKER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER0_HOST "~/$COMMAND_FILE"
echo "Done enabling IP forwarding in worker 0"
#
#
echo "Enabling IP forwarding in worker 1"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$WORKER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER1_HOST "~/$COMMAND_FILE"
echo "Done enabling IP forwarding in worker 1"
