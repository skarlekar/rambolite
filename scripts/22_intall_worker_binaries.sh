echo "Starting setup kubernetes binaries on worker 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_install_worker_binaries.sh ubuntu@$WORKER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER0_HOST '~/commands_install_worker_binaries.sh'
echo "Done setting up kubernetes binaries on worker 0"
#
#
echo "Starting setup kubernetes binaries on worker 1"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_install_worker_binaries.sh ubuntu@$WORKER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$WORKER1_HOST '~/commands_install_worker_binaries.sh'
echo "Done setting up kubernetes binaries on worker 1"
