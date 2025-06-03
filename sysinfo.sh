#!/bin/bash

hostname=$(hostname)
os=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
uptime=$(uptime -p)
users_count=$(who | wc -l)
ip_address=$(hostname -I | awk '{print $1}')  # Первый внешний IP

output="HOSTNAME: $hostname\nOS: $os\nUPTIME: $uptime\nCOUNT OF USERS: $users_count\nIP ADDRESS: $ip_address"

help="-h\t\tShow help information\n-s\t\tOutput to the command line\n-f [FILE]...\tOutput to the file"

if [ $# -eq 0 ]; then
    echo "Use -h for help."
    exit 1
fi

while [ -n "$1" ]; do
    case "$1" in
        -h) echo -e "$help" ;;
        -s) echo -e "$output" ;;
        -f)
            if [ -z "$2" ]; then
                echo "Error: specify a filename after -f"
                exit 1
            fi
            echo -e "$output" > "$2"
            shift ;;
        *) echo "Unknown option: $1" ;;
    esac
    shift
done

exit 0
