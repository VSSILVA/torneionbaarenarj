#!/usr/bin/env bash
set -euo pipefail

sudo cp /home/igordnt/basketmaster/deploy/basketmaster-nginx.conf /etc/nginx/sites-available/basketmaster
sudo ln -sfn /etc/nginx/sites-available/basketmaster /etc/nginx/sites-enabled/basketmaster
sudo nginx -t
sudo systemctl reload nginx

echo "HTTP vhost installed for basketmaster.com.br and www.basketmaster.com.br"
