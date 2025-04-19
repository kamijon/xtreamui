#!/bin/bash

# بررسی اجرای اسکریپت با دسترسی ریشه
if [ "$EUID" -ne 0 ]; then
  echo "لطفاً این اسکریپت را با دسترسی root اجرا کنید."
  exit 1
fi

# به‌روزرسانی سیستم
apt update && apt upgrade -y

# نصب وابستگی‌های مورد نیاز
apt install -y sudo curl wget unzip zip net-tools cron nginx \
  php php-cli php-mysql php-curl php-mbstring php-xml php-bcmath \
  software-properties-common ffmpeg mysql-server

# پیکربندی فایروال
ufw allow OpenSSH
ufw allow 25461/tcp
ufw allow 25500/tcp
ufw allow 8000:8100/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

# دانلود فایل‌های نصب از ریپوی GitHub
cd /opt
git clone https://github.com/kamijon/xtreamui-autoinstall.git
cd xtreamui-autoinstall/xtreamui

# اجرای اسکریپت نصب داخلی
bash install.sh

