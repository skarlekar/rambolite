kubectl create secret generic my-secret --from-literal="name=karlekar"
COMMAND_FILE=commands_dump_secrets.sh
echo "Encrypting secret and viewing it using Kubectl in Controller 0"
scp -i $SSH_ID_FILE $SCRIPTS_DIR/$COMMAND_FILE ubuntu@$CONTROLLER0_HOST:~/
ssh -i $SSH_ID_FILE ubuntu@$CONTROLLER0_HOST "~/$COMMAND_FILE"
echo "Look for k8s:enc:aescbc:v1:key1 on the right of the output to verify that the data is stored in an encrypted format!"
echo "Done ncrypting secret and viewing it using Kubectl in Controller 0"
