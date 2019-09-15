COMMAND_FILE=commands_install_weave_net.sh
echo "Installing Weave Net using Kubectl in Controller 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST "~/$COMMAND_FILE"
echo "Done installing Weave Net using Kubectl in Controller 0"
