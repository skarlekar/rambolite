PROJECT_NAME=$1
HANDLER_URL=$2
WORKDIR="FMEF_$PROJECT_NAME"

mkdir $WORKDIR
cd $WORKDIR
#wget -q --show-progress --https-only --timestamping $HANDLER_URL
curl -O $HANDLER_URL
FILENAME=`python ../get-file-name-from-url.py $HANDLER_URL`
faas-cli new --lang python3 $PROJECT_NAME --prefix="skarlekar"
cp $FILENAME $PROJECT_NAME/handler.py

echo "Press enter to continue" && read
faas-cli build -f ./$PROJECT_NAME.yml
echo "Press enter to continue" && read
faas-cli push -f ./$PROJECT_NAME.yml
echo "Press enter to continue" && read
faas-cli deploy -f ./$PROJECT_NAME.yml
