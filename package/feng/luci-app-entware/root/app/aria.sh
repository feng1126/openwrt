#!/bin/bash
/opt/etc/init.d/S81aria2 stop
list=`wget --no-check-certificate https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best_ip.txt|awk NF|sed ":a;N;s/\n/,/g;ta"`

if [ -z "`grep "bt-tracker" /opt/etc/aria2.conf`" ]; then
    sed -i '$a bt-tracker='${list}  /opt/etc/aria2.conf
    echo add......
else
    sed -i "s@bt-tracker.*@bt-tracker=$list@g"  /opt/etc/aria2.conf
    echo update......
fi

/opt/etc/init.d/S81aria2 start
