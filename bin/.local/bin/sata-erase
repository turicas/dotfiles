#!/bin/bash

# Based on <https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing>
# and <https://code.mendhak.com/securely-wipe-ssd/>

device="$1"

if [[ -z $device ]]; then
	echo "ERROR - Usage: $0 <device>"
	exit 1
elif [[ $(whoami) != "root" ]]; then
	echo "ERROR - Must be run as root"
	exit 2
fi

echo "WARNING: this will destroy ALL DATA inside the device irreversibly. Do you want to continue? (y/N)"
read answer

if [[ $answer != "y" ]]; then
	exit 0
fi

echo "Checking if device is frozen..."
if [[ $(hdparm -I $device | grep --color=no -i frozen | grep --color=no not | wc -l) = 0 ]]; then
	echo "ERROR: device is frozen, cannot continue. Unfreeze it and try again"
	exit 3
fi

echo "Writing random data..."
time dd if=/dev/urandom of=$device oflag=sync bs=8M status=progress

password=$(dd if=/dev/urandom count=8 bs=1 status=none | base64)
echo "Setting a security password ($password)..."
time hdparm --user-master masteruser --security-set-pass "$password" $device

echo "Issuing SATA security erase enhanced command..."
time hdparm --user-master masteruser --security-erase-enhanced "$password" $device

echo "Writing zeroes..."
time dd if=/dev/zero of=$device oflag=sync bs=8M status=progress
