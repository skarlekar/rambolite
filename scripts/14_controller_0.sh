#ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST 'bash -s' < $SCRIPTS_DIR/commands_install_etcd.sh
#scp -i $SSH_ID_FILE $SCRIPTS_DIR/commands_gen_systemd_unit_file.sh ubuntu@$CONTROLLER0_HOST:~/
#
#TEMP_FILE_C0=/tmp/c0_etcd_install.sh
#if test -f "$TEMP_FILE_C0"; then
#    echo "Removing $TEMP_FILE_C0"
#    rm $TEMP_FILE_C0
#fi
#
cat << EOF | tee TEMP_FILE_C0
export ETCD_NAME=$CONTROLLER0_HOST
export INTERNAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
export INITIAL_CLUSTER=$CONTROLLER0_HOST=https://$CONTROLLER0_IP:2380,$CONTROLLER1_HOST=$CONTROLLER1_IP:2380
chmod +x commands_gen_systemd_unit_file.sh
~/commands_gen_systemd_unit_file.sh
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd
sudo systemctl status etcd
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem
EOF
echo "Done Generating tempfile"
#chmod +x $TEMP_FILE_C0
#scp -i $SSH_ID_FILE $TEMP_FILE_C0 ubuntu@$CONTROLLER0_HOST:~/
##ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST '~/c0_etcd_install.sh'
#
