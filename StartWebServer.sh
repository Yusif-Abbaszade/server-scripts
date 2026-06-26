#!/bin/bash
USER=${user}
TOKEN=${token}

REPO_URL="https://${USER}:${TOKEN}@github.com/Motiv-az/Motiv-frontend.git"
TARGET_DIR="/usr/share/nginx/Motiv-frontend"

# Clone or Update
if [ -d "$TARGET_DIR" ]; then
    echo "Directory exists. Pulling latest changes..."
    cd "$TARGET_DIR" && sudo git pull "$REPO_URL"
else
    echo "Cloning repository..."
    sudo git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"

echo "Installing node modules..."

/usr/bin/bun install

echo "Building the project..."

/usr/bin/bun run build

echo "Deploying to Nginx directory..."

cp -r $TARGET_DIR/dist/* /usr/share/nginx/html/

echo "Fixing permissions for Nginx..."

sudo chown -R nginx:nginx /usr/share/nginx/html/
sudo chmod -R 755 /usr/share/nginx/html/

echo "Starting Nginx server..."

systemctl start nginx

echo "Starting ngrok..."

# /usr/bin/ngrok http 80
/usr/bin/ngrok http 80 --config /home/${USER}/.config/ngrok/ngrok.yml --log=stdout
