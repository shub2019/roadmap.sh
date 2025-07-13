#!/bin/bash

echo "===== CPU Usage ====="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

echo -e "\n===== Memory Usage ====="
free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo -e "\n===== Disk Usage (/) ====="
df -h / | awk 'NR==2{printf "Used: %s / Total: %s (Used: %s)\n", $3, $2, $5}'

echo -e "\n===== Top 5 Processes by CPU ====="
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo -e "\n===== Top 5 Processes by Memory ====="
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
