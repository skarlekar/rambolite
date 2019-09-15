echo "Starting setup kubernetes scheduler controller 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_kube_scheduler_systemd.sh ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST '~/commands_gen_kube_scheduler_systemd.sh'
echo "Done setting up kubernetes scheduler on controller 0"
#
#
echo "Starting setup kubernetes scheduler controller 1"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_kube_scheduler_systemd.sh ubuntu@$CONTROLLER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST '~/commands_gen_kube_scheduler_systemd.sh'
echo "Done setting up kubernetes scheduler on controller 1"
