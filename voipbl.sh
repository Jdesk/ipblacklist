#!/bin/bash

# Check if chain exists and create one if required
if [ `iptables -L | grep -c "Chain BLACKLIST-INPUT"` -lt 1 ]; then
  /sbin/iptables -N BLACKLIST-INPUT
  /sbin/iptables -I INPUT 1 -j BLACKLIST-INPUT
fi
	
# Empty the chain
/sbin/iptables -F BLACKLIST-INPUT
wget -qO - http://www.voipbl.org/update/ |\
  awk '{print "if [ ! -z \""$1"\" -a \""$1"\" !=  \"#\" ]; then /sbin/iptables -A BLACKLIST-INPUT -s \""$1"\" -j DROP;fi;"}' | sh
