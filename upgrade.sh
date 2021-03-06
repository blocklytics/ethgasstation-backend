#!/bin/bash
set -e

# Run following command to execute the script:
# systemctl stop apache2 && systemctl stop ethgassbackend && cd /usr/local/SettleFinance/ethgasstation-backend && git fetch --all && git reset --hard origin/master && git pull && chmod -R 777 /usr/local/SettleFinance/ethgasstation-backend/upgrade.sh && ./upgrade.sh

#For Initial Setup
#	mkdir -p -v /usr/local/SettleFinance
#	cd /usr/local/SettleFinance
#	git clone https://github.com/SettleFinance/ethgasstation-frontend.git
#	git clone https://github.com/SettleFinance/ethgasstation-backend.git
#	cd ethgasstation-backend

echo "####################################"
echo "# ETH GAS STARTION BACKEND UPGRADE #"
echo "####################################"
echo "Replica PUBLIC IP Address:"
dig +short myip.opendns.com @resolver1.opendns.com

rm -v /usr/local/SettleFinance/ethgasstation-backend/settings.classic.conf || echo "Config file was probably already removed.";

cp -v /etc/ethgasstation/settings.conf /usr/local/SettleFinance/ethgasstation-backend/settings.conf

chmod -R 777 /usr/local/SettleFinance/ethgasstation-backend

echo "Starting Frontend And Backend..."
systemctl start ethgassbackend
sleep 3
systemctl start apache2

echo "Checking Disk Space"
df

echo "Last Backend Startus: "
journalctl --unit=ethgassbackend -n 25 --no-pager

#geth status verify command:
#journalctl --unit=geth -n 100 --no-pager

#backend status verify
#journalctl --unit=ethgassbackend -n 100 --no-pager

#to edit backend config
#nano /etc/ethgasstation/settings.conf

#backed output json location:
#/var/www/ethgasstation.settle.host/public_html/json

#backed output cleanup & reboot
#rm -r -f -v /var/www/ethgasstation.settle.host/public_html/json/* && chmod -R 777 /var/www/ethgasstation.settle.host/public_html/json && systemctl restart ethgassbackend && systemctl restart geth

#backend service restart
#systemctl restart ethgassbackend

#backed output json location:
#/var/www/ethgasstation.settle.host/public_html/json
