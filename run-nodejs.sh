#!/bash/sh

sudo apt update

#Install packages
echo "Installing..."
sudo apt install nodejs npm curl net-tools -y

#Display Node JS version
echo "Node JS version: $(node -v)"
echo

#Display NPM version
echo "NPM version: $(npm -v)"
echo

#Download NodeJS project
echo "Downloading node JS project tar..."
sudo wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

echo "Extracting tar file.."
sudo tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz

#Set environment variables
echo "Setting environment variables..."

ENV_FILE="$HOME/.app_env"

cat > "$ENV_FILE" <<'EOF'
export APP_ENV="dev"
export DB_USER="myuser"
export DB_PWD="mysecret"
EOF




cd package

#install npm
echo
echo "Installing npm dependencies..."
npm install
echo


#Kill if node is already running
if [ -f server.pid ]; then
  kill "$(cat server.pid)" || true
fi

#Start Node JS
echo "Running Node JS application..."
node server.js > server.log 2>&1 &
echo $! > server.pid


# Display that nodejs process is running
echo

echo "Node processes running:"
pgrep -u "$USER" -l node

sleep 1

#PORT=$(sudo /usr/sbin/netstat -plnt 2>/dev/null | grep node | awk '{print $4}' | awk -F':' '{print $NF}')
#echo "Node is listening on port: $PORT"

#Get NodeJS port
port=$(sudo netstat -pl|grep node|awk '{print $4}'|awk -F':' '{print $4}')
echo "Node is listening on port: $port"
