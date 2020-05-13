#!/bin/bash

LSUB=`lsusb | grep -i "Future Technology"`
DEV=${LSUB:4:3}/${LSUB:15:3}
echo $DEV
sudo iceprog -d d:$DEV Go_Board_Full_Test_bitmap.bin
