echo "Starting setup control plane on controller 0"
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST 'bash -s' < $SCRIPTS_DIR/commands_install_control_plane.sh
echo "Done installing control plane on controller 0"
#
#
echo "Starting setup control plane on controller 1"
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST 'bash -s' < $SCRIPTS_DIR/commands_install_control_plane.sh
echo "Done installing control plane on controller 1"
