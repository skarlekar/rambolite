ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST 'bash -s' < $SCRIPTS_DIR/a_install_etcd.sh
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST 'bash -s' < $SCRIPTS_DIR/a_install_etcd.sh
