#!/bin/bash
####################################################
# Command queue run at scheduled time              #
# Author: yinxt at 2017.12.04                      #
# sudo apt-get install at //install command at     #
# SUCESS: echo "./night.sh" |at now +1 minutes     #
####################################################
# *Do NOT use: at -f night.sh now +2 hours (source #
#              result not return to this shell)    #
####################################################
log_file=./log-$(date +%Y%m%d-%H:%M:%S).txt
exec 2>&1 >$log_file
echo "Start the work at: "$(date +%X)

##Start (write down the shell commands line by line)
#source ./build/envsetup.sh
#lunch copper-userdebug
#make fullbuild -j16
##End

echo "Finished the work quence at: "$(date +%X)
