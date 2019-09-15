echo "Starting setup nginx on load balancer"
ssh -i $SSH_ID_FILE ubuntu@$LB_HOST 'bash -s' < $SCRIPTS_DIR/commands_config_load_balancer.sh $CONTROLLER0_IP $CONTROLLER1_IP 
echo "Done setup nginx on load balancer"
