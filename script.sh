#!/usr/bin/env bash
##############################################################
# Title  : script.sh                                         #
# Author : k0nsl  (i.am@k0nsl.org)                           #
#                                                            #
# Description : This is a rudimentary Bash script for        #
#               importing spammer's IP addresses and         #
#               adding them to a blackhole.                  #
#                                                            #
# Last modified on Tue Jul 11 12:31:22 CEST 2017             #
##############################################################

[[ -f /tmp/spammer.list ]] && /bin/rm -f /tmp/spammer.list
/usr/bin/curl -o /dev/null www.debian.org -sm3
if [[ $? != 0 ]]; then
	echo -e "\e[35mNo Connection!\e[0m"
	exit 1
else
/usr/bin/curl --silent -A "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.82 Safari/537.36" https://raw.githubusercontent.com/k0nsl/spammer-kartotek/master/spammers.list >> "/tmp/spammer.list"
for i in `/bin/cat /tmp/spammer.list|/bin/grep -v "#"`
do
IPADDR=$i
/bin/ip route add blackhole $IPADDR
/usr/bin/logger "$IPADDR has been sent to a blackhole."

done
fi
