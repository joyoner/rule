#!/bin/sh
rm -rf "/tmp/speed"
"/root/speedtest" -s44932  >  "/tmp/speed"
ls1=`cat /tmp/speed | grep Upload | sed 's/\r[ \t]*//g' | sed 's/Upload/U/g'`
ls2=`cat /tmp/speed | grep Download | sed 's/\r[ \t]*//g' | sed 's/Download/D/g'`
lsn=XXX
tgid=
tgbotapi=
curl --data chat_id="$tgid" --data-urlencode "text=§$lsn§
$ls1
$ls2" "https://api.telegram.org/bot$tgbotapi/sendMessage?parse_mode=HTML"

10 * * * * bash /root/lovespeed.sh > /dev/null 2>&1
