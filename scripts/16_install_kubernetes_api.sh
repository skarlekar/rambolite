echo "Starting setup kubernetes api on controller 0"
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST 'bash -s' < $SCRIPTS_DIR/commands_install_kubernetes_api.sh
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_kubernetes_api.sh ubuntu@$CONTROLLER0_HOST:~/

TEMP_FILE_C0=c0_kubernetes_install.sh
if test -f "$TEMP_FILE_C0"; then
    echo "Removing $TEMP_FILE_C0"
    rm $TEMP_FILE_C0
fi

cat $SCRIPTS_DIR/kubernetes_install_template| sed 's@CONTROLLER0_PRIVATE_IP@'"$CONTROLLER0_IP"'@g' | sed 's@CONTROLLER1_PRIVATE_IP@'"$CONTROLLER1_IP"'@g' > $TEMP_FILE_C0
chmod +x $TEMP_FILE_C0
scp -i $SSH_ID_FILE $TEMP_FILE_C0 ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST '~/c0_kubernetes_install.sh'
rm $TEMP_FILE_C0
echo "Done setting up kubernetes api on controller 0"
#
#
echo "Starting setup kubernetes api on controller 1"
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST 'bash -s' < $SCRIPTS_DIR/commands_install_kubernetes_api.sh
scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_kubernetes_api.sh ubuntu@$CONTROLLER1_HOST:~/

TEMP_FILE_C1=c1_kubernetes_install.sh
if test -f "$TEMP_FILE_C1"; then
    echo "Removing $TEMP_FILE_C1"
    rm $TEMP_FILE_C1
fi

cat $SCRIPTS_DIR/kubernetes_install_template| sed 's@CONTROLLER0_PRIVATE_IP@'"$CONTROLLER0_IP"'@g' | sed 's@CONTROLLER1_PRIVATE_IP@'"$CONTROLLER1_IP"'@g' > $TEMP_FILE_C1
chmod +x $TEMP_FILE_C1
scp -i $SSH_ID_FILE $TEMP_FILE_C1 ubuntu@$CONTROLLER1_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER1_HOST '~/c1_kubernetes_install.sh'
rm $TEMP_FILE_C1
echo "Done setting up kubernetes api on controller 1"
