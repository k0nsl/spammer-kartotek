#!/usr/bin/env bash
[[ -f /tmp/spammer.list ]] && rm -f /tmp/spammer.list
curl -o /dev/null www.debian.org -sm3
if [[ $? != 0 ]]; then
	echo -e "\e[35mNo Connection!\e[0m"
	exit 1
else
curl --silent -A "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.82 Safari/537.36" https://raw.githubusercontent.com/k0nsl/spammer-kartotek/master/spammers.list >> "/tmp/spammer.list"
for i in `cat /tmp/spammer.list|grep -v "#"`
do
IPADDR=$i
ip route add blackhole $IPADDR
logger "$IPADDR has been sent to a blackhole."

done
fi
