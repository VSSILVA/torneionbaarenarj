#!/usr/bin/env bash
set -euo pipefail

sudo certbot --nginx \
  -d basketmaster.com.br \
  -d www.basketmaster.com.br \
  --redirect

sudo nginx -t
sudo systemctl reload nginx

echo "HTTPS enabled for basketmaster.com.br and www.basketmaster.com.br"
