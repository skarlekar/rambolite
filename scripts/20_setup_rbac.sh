echo "Starting setup rbac on controller 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_setup_rbac.sh ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST '~/commands_setup_rbac.sh'
echo "Done setting up rbac on controller 0"
