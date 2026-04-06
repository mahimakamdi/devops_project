#!/bin/bash

echo "===== SYSTEM INFO ====="
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "OS: $(uname -o)"
echo "Kernel: $(uname -r)"
echo "CPU: $(lscpu | grep 'Model name' | awk -F ':' '{print $2}')"
echo "Memory:"
free -h