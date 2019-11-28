#!/bin/bash
# ------------------------------------------------------------------
#
#     bin/chunk_cpu_usage.sh
#     Description: Script for CPU usage
#                  feed to dzen.
#
#     Source
#     http://stackoverflow.com/questions/26791240/how-to-get-percentage-of-processor-use-with-bash
#
#     Modified by: Epsi Nurwijayadi <epsi.nurwijayadi@gmail.com)
#
# ------------------------------------------------------------------

# $ cat /proc/stat
# - user: normal processes executing in user mode
# - nice: niced processes executing in user mode
# - system: processes executing in kernel mode
# - idle: twiddling thumbs
# - iowait: waiting for I/O to complete
# - irq: servicing interrupts
# - softirq: servicing softirqs
# - steal: involuntary wait
# - guest: running a normal guest
# - guest_nice: running a niced guest

# Read /proc/stat file (for first datapoint)
read cpu user nice system idle iowait irq softirq steal guest< /proc/stat

# compute active and total utilizations
cpu_active_prev=$((user+system+nice+softirq+steal))
cpu_total_prev=$((user+system+nice+softirq+steal+idle+iowait))

# echo 'cpu_active_prev = '.cpu_active_prev

sleep 1

# Read /proc/stat file (for second datapoint)
read cpu user nice system idle iowait irq softirq steal guest< /proc/stat

# compute active and total utilizations
cpu_active_cur=$((user+system+nice+softirq+steal))
cpu_total_cur=$((user+system+nice+softirq+steal+idle+iowait))

# compute CPU utilization (%)
cpu_util=$((100*( cpu_active_cur-cpu_active_prev ) / (cpu_total_cur-cpu_total_prev) ))

echo -n $cpu_util

exit 0
