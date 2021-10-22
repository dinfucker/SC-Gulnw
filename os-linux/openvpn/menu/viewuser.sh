#!/bin/bash
clear
cr
echo -e " " 
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "📮No   📮ชื่อ         📮สถานะ       📮หมดอายุ   "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
 C=1
 ON=0
 OFF=0
while read mumetndase
do
        acout="$(echo $mumetndase | cut -d: -f1)"
        ID="$(echo $mumetndase | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $acout | grep "Account expires" | awk -F": " '{print $2}')"
        online="$(cat /etc/openvpn/log.log | grep -Eom 1 $acout | grep -Eom 1 $acout)"
        if [[ $ID -ge 500 ]]; then
        if [[ -z $online ]]; then
        printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "------" "$exp"
        OFF=$((OFF+1))
        else
        printf "%-4s %-15s %-10s %-3s\n" "$C." "$acout" "online" "$exp"
        ON=$((ON+1))
        fi
        C=$((C+1))
        fi
done < /etc/passwd
TOTAL="$(awk -F: '$3 >= '1000' && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo "  online : $ON     ofline : $OFF    limit : $TOTAL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo -e " " 