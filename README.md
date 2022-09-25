# ddc-autobright

A shell script which adjusts the brightness of a connected ddc monitor
according to the brightness set on the Intel-Chipset driven laptop monitor.

## Requirements

A working ddcutil installation, along with the i2c kernel module loaded. 
Otherwise the external monitor can not be detected properly.

## Installation and configuration

The VCP code for brightness setting of your particular monitor might vary from
my default value, so you need to check that before using this script. You can
find the correct VCP code using the tool "ddcui" and selecting the "Features"
option from the "View" Menu. Look for the brightness slider and the code will
be in the first column of the features table.
Put it into the script (only the number, not the leading "x")
Then add the autobrightd.sh script to the autostart mechanism of the desktop
environment of your choice.
