#
# Copy the file to both controller servers:
#
scp -i $SSH_ID_FILE encryption-config.yaml ubuntu@$CONTROLLER0_HOST:~/
scp -i $SSH_ID_FILE encryption-config.yaml ubuntu@$CONTROLLER1_HOST:~/
