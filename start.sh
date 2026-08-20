#!/bin/bash
set -e

echo "🚀 Starting 3X-UI (v3.6.0) + Nginx..."

# دریافت پورت متغیر از محیط Railway یا پورت پیش‌فرض 3000
export NGINX_PORT=${PORT:-3000}

cd /usr/local/x-ui

echo "🔧 Setting up x-ui configuration..."
# تنظیم پورت داخلی پنل و BasePath
./x-ui setting -port 2053 -webBasePath /managepanel/ || true

echo "🔧 Building nginx.conf for port: $NGINX_PORT"
envsubst '${NGINX_PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "▶️ Starting x-ui process..."
./x-ui &

sleep 3

echo "▶️ Starting nginx on port $NGINX_PORT..."
nginx -t
exec nginx -g "daemon off;"
