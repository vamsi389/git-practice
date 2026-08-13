#!/bin/bash

info(){
	echo "Hostname: " $(hostname)
	echo "    "
	echo "Userslogged in : " $(w)
	echo "    "
	echo "Kernel Veraion: " $(uname -r)
	echo "    "
	echo "OS: Version: " $(cat /etc/os-release)
	echo "    "
	echo "Uptime of the System is: " $(uptime)
}

cpu(){
	echo "       "
	echo "CPU cores of the system: " $(cat /proc/cpuinfo)
	echo "       "
	echo "CPU load on the system is: " $(top | awk 'NR==1 {print $9,$10,$11,$12,$13}')
}

mem(){
	echo "          "
	echo -e "Memory Usage of the System is:\n\n$(free -m | awk 'BEGIN { printf "%-15s %-10s %-15s %-10s\n","Parameter","Total","Used","Available" } NR>1 {printf "%-15s %-10s %-15s %-10s\n",$1,$2,$3,$4}')"
}

disk(){
	echo "           "
	echo -e "Disk Usage in the system is:\n\n$(df -kh | awk 'BEGIN {printf "%-15s %-10s %-20s %-15s %-10s\n","File System","Size","Used","Available","Usage in %"} NR>1 {printf "%-15s %-10s %-20s %-15s %-10s\n",$1,$2,$3,$4,$5}')"
}

diskalert(){
	echo "              "
	echo -e "Disk health status is:\n\n$(df -h | awk '

BEGIN {
        printf "%-15s %-10s %-20s\n","FileSystem","Usage","HealthStatus"
}

NR>1 {
        gsub("%","",$5)
        usage=$5+0
        if(usage>50) 
        {
                printf "%-15s %-10s %-20s\n",$1,$5,"UnHealthy"
        }
        else 
        {
                printf "%-15s %-10s %-20s\n",$1,$5,"Healthy"
        }

}')"
}

service(){
	echo "             "
	echo -e "Service Status is :\n\n$(read -p "Enter service name: " service
	systemctl status $service > /dev/null 2>&1
	status=$?
	if [ $status -eq 0 ]; then
		echo "Service is in runing state"
	elif [ $status -eq 3 ]; then
        	echo "Service is inactive"
	else
        	echo "Service not found"
	fi)"
}

loganalyzer(){

	read -p "Enter the log file path: " file

	if [ -f "$file" ]; then
        	error_count=$(grep -ic "error" "$file")
        	info_count=$(grep -ic "info" "$file")
        	warn_count=$(grep -ic "warning" "$file")
        	echo "               "
        	echo "----SUMMARY------"
        	echo "               "
        	echo "Error count is: "$error_count""
        	echo "                "
        	echo "Warning count is: "$warn_count""
        	echo "               "
        	echo "Info count is: "$info_count""
        	echo "                "
        	echo "Last 3 error lines: "
        	echo "                    "
        	grep -i "error" $file | tail -n 3
	else
        	echo "file in path "$file" not found"
		continue

	fi
}

echo "================================================"
echo "            LINUX INFRA TOOLKIT                 " 
echo "================================================"
echo "              "

while true
do
	read -p "Enter your choice:

1) System Information
2) CPU Usage
3) Memory Usage
4) Disk Usage
5) Disk Alert
6) Service Status
7) Log Analyzer
8) Exit

choice: " choice


	case $choice in 

	1)
		info
		;;

	2)
		cpu
		;;

	3)
		mem
		;;

	4)
		disk
		;;

	5)
		diskalert
		;;

	6)
		service
		;;

	7)
		loganalyzer
		;;

	8)
		echo "Exiting from script"
		exit 0
		;;

	*)
		echo "Please enter the choices from [1-8]"
		;;

	esac
done
