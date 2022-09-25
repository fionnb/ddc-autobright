#!/bin/bash
# (c) 2022 oss@fionn.de

VCP_CODE=10 # <-- you need to set this to the VCP code of your ddc monitor!
BRIGHT_BASE="/sys/class/backlight/intel_backlight/"
CUR_BRIGHT="brightness"
MAX_BRIGHT="max_brightness"
MIN_BRIGHT=1

#--------------

which ddcutil >/dev/null 2>&1 
if [ $? -gt 0 ]; then
  echo "error: needs ddcutil" && exit 1 
fi

SYS_BRIGHT="$BRIGHT_BASE/$CUR_BRIGHT"
MAX_BRIGHT=$(cat $BRIGHT_BASE/$MAX_BRIGHT)
EXT_MON="$(ddcutil detect --force-slave-address | grep "i2c-" | cut -d "-" -f2 | tail -n +2)"
if [ -z $EXT_MON ]; then
  echo "no external ddc devices found. did you modprobe i2c-dev?"
  exit 1
fi
LAST_B=0

while true; do
  BRIGHT=$(( 100 * $(cat $SYS_BRIGHT) / $MAX_BRIGHT ))
  if [ $BRIGHT -lt $MIN_BRIGHT ]; then
    BRIGHT=$MIN_BRIGHT
  fi
  if [ $BRIGHT -ne $LAST_B ]; then
    echo "bright changed to $BRIGHT ..."
    for MON in $EXT_MON; do
      ddcutil --force-slave-address --bus $MON setvcp $VCP_CODE $BRIGHT
    done
    LAST_B=$BRIGHT
  fi
  sleep 1
done
