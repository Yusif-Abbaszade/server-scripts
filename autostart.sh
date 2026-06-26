#!/bin/bash

MAIN_PATH="/data/data/com.termux/files/home/"
#domain="yusif.qzz.io"
#subdomains=("" "test" "exam")
#config_file=$(<"${MAIN_PATH}.cloudflared/config.yml")
#hostnames= echo ${config_file} | grep "hostname"
#echo $hostnames

k=0
hostnames=()
services=()
line_tmp=""


while IFS= read -r line; do
    if [[ $k == 1 ]];then
        k=0
        line_tmp=$(echo $line | awk '{print $2}')
        services+=("${line_tmp}")
    fi
    if [[ $line == *"hostname"* ]];then
	k=1
	line_tmp=$(echo $line | awk '{print $3}')
	#echo "$line_tmp"
	hostnames+=("${line_tmp}")
    fi
done < "${MAIN_PATH}.cloudflared/config.yml"

#echo "$hostnames"
#printf '%s\n' "${hostnames[@]}"
#printf '%s\n' "${services[@]}"

n_host="${#hostnames[@]}"
n_serv="${#services[@]}"

if [ "${n_host}" != "${n_serv}" ];then
    echo "config.yml corrupted."
    exit 0
fi

nohup cloudflared tunnel run phone-server &
echo "Cloudflare phone-server started"


for ((i=0; i<$n_host; i++)); do
    port=$(echo "${services[i]}" | awk -F: '{print $3}')
    cd "${MAIN_PATH}${hostnames[i]}"
    if [ -f "index.js" ]; then
	echo "index.js found"
        nohup node index.js &
    else
        echo "index.js does not exist here."
	nohup python -m http.server "${port}" &
    fi

    echo "${hostnames[i]} started on ${services[i]}"
done
