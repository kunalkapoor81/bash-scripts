#!/bash/sh

sudo apt update

echo "Installing nodejs..."
sudo apt install nodejs npm -y

echo "Node JS version: $(node -v)"
echo

echo "NPM version: $(npm -v)"
echo

echo "Downloading node JS project tar..."
sudo wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

echo "Extracting tar file.."
sudo tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz


echo "Setting environment variables..."

ENV_FILE="$HOME/.app_env"

cat > "$ENV_FILE" <<'EOF'
export APP_ENV="dev"
export DB_USER="myuser"
export DB_PWD="mysecret"
EOF




cd package

echo
echo "Installing npm dependencies..."
npm install
echo


echo "Running Node JS application..."
node server.js > server.log 2>&1 &


