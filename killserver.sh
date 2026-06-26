#!/bin/bash

killall cloudflared
echo "cloudflared killed"
killall python
echo "python servers killed"

sleep 2
echo ""
echo "printing process related to python and cloudflared"
echo ""
echo ""
ps aux | grep python
ps aux | grep cloudflared
