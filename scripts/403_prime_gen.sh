echo "Please login to docker hub using the following:"
echo "docker login -u "user-name" -p "password"
echo "Press enter to continue" && read

# Get the password for OpenFaas  admin user
echo "Enter OpenFaas Password for the 'admin' user:"
read PASSWORD
export OPENFAAS_URL=http://127.0.0.1:31112

# Start OpenFaas portal and redirect to localhost:31112
kubectl port-forward svc/gateway -n openfaas 31112:8080 &

# Login to OpenFaas cli with the password
echo -n $PASSWORD | faas-cli login --password-stdin

# Generate a new OpenFaas function
faas-cli new --lang python3 prime-gen --prefix="skarlekar"


echo "Press enter to continue" && read
mv ./prime-gen/handler.py ./prime-gen/handler.py.bak
cp $SCRIPTS_DIR/prime-gen.py ./prime-gen/handler.py

faas-cli build -f ./prime-gen.yml
faas-cli push -f ./prime-gen.yml

echo "Press enter to continue" && read
faas-cli deploy -f ./prime-gen.yml
