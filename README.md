# roadmap.sh
vi server-stats.sh

✅ 1. Total CPU Usage
🔹 Command:
            top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
🔍 Breakdown:
top: Shows real-time system resource usage (like Task Manager in Windows).
-b: Batch mode – useful for scripts (non-interactive).
-n1: Run the command once.
| grep "Cpu(s)": Filters to show only the line with CPU info.
Sample output line: %Cpu(s):-  5.0 us,  3.0 sy,  0.0 ni, 92.0 id, ...
  awk '{print "CPU Usage: " 100 - $8 "%"}':
  $8 refers to the 8th column, which is the idle percentage (id).
  So 100 - $8 gives the used CPU percentage.
  print displays it neatly.
  
✅ 2. Total Memory Usage (Free vs Used)
🔹 Command:
           free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'
🔍 Breakdown:
free -m: Shows memory usage in megabytes.
              total        used        free
Mem:           7988        3456        4532
NR==2: Selects the second line (Mem:).
$2: Total memory
$3: Used memory
$3*100/$2: Calculates the used percentage
printf: Formats the output like:- Used: 3456MB / Total: 7988MB (43.26%)

✅ 3. Total Disk Usage (Root / Partition)
🔹 Command:
            df -h / | awk 'NR==2{printf "Used: %s / Total: %s (Used: %s)\n", $3, $2, $5}'
🔍 Breakdown:
df -h /: Shows disk usage of / in human-readable format (-h).
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1       20G   10G  9.5G  50% /
NR==2: Skips the header, selects data line.
$2: Total disk size (e.g., 20G)
$3: Used space (e.g., 10G)
$5: Use% (e.g., 50%)
printf: Formats output like: Used: 10G / Total: 20G (Used: 50%)


✅ 4. Top 5 Processes by CPU Usage
🔹 Command:
            ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
🔍 Breakdown:
ps: Displays information about running processes.
-e: Show all processes.
-o pid,comm,%cpu: Only show:
pid: Process ID
comm: Command name (process name)
%cpu: CPU usage percentage
--sort=-%cpu: Sort descending by CPU usage.
head -n 6: First line is a header, next 5 lines are top 5 CPU consumers.

✅ 5. Top 5 Processes by Memory Usage
🔹 Command:
            ps -eo pid,comm,%mem --sort=-%mem | head -n 6
🔍 Breakdown:
Almost same as the previous command, but:
%mem: Memory usage
--sort=-%mem: Sorted by highest memory use
Shows top 5 memory-hungry processes.

✅ Final Combined Output (example):
===== CPU Usage =====
CPU Usage: 14.2%

===== Memory Usage =====
Used: 3456MB / Total: 7988MB (43.26%)

===== Disk Usage (/) =====
Used: 10G / Total: 20G (Used: 50%)

===== Top 5 Processes by CPU =====
  PID COMMAND         %CPU
 1234 python3         12.3
 2345 java             8.1
 3456 nginx            5.6
 ...

===== Top 5 Processes by Memory =====
  PID COMMAND         %MEM
 1234 java            23.4
 2345 python3         18.9
 3456 postgres         7.1


## 🚀 How to Run
chmod +x server-stats.sh
./server-stats.sh
