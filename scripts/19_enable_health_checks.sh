echo "Starting setup kubernetes health check on controller 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_enable_health_checks.sh ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST '~/commands_enable_health_checks.sh'
echo "Done setting up kubernetes health check on controller 0"
#
#
echo "Starting setup kubernetes health check on controller 1"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_enable_health_checks.sh ubuntu@$CONTROLLER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST '~/commands_enable_health_checks.sh'
echo "Done setting up kubernetes health check on controller 1"
