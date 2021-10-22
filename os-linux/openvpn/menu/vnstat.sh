#!/bin/bash
if [ -d '/home/vps/public_html/vnstat' ]; then
	echo; echo; echo " "
	clear
else
apt-get update 
apt-get -y upgrade
apt-get -y install vnstat
chown -R vnstat:vnstat /var/lib/vnstat

# install vnstat gui
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php
clear
echo " ╭━━━━━━━━━━━━╮
 ┣สถานะการติดตั้ง
 ╰━━━━━━━━━━━━╯"
service vnstat restart
vnstat -u -i eth0
echo " ╭━━━━━━━━━━━━╮
 ┣ติดตั้งเสดเรียบร้อย
 ╰━━━━━━━━━━━━╯"
exit
 fi
if [[ $1 == "" ]]
then
if [[ -e /etc/vnstat.conf ]]; then
	INTERFACE=`vnstat -m | head -n2 | awk '{print $1}'`
	TOTALBW=$(vnstat -i $INTERFACE --nick local | grep "total:" | awk '{print $8" "substr ($9, 1, 1)}')
fi

ON=0
OFF=0
while read ONOFF
do
	ACCOUNT="$(echo $ONOFF | cut -d: -f1)"
	ID="$(echo $ONOFF | grep -v nobody | cut -d: -f3)"
	ONLINE="$(cat /etc/openvpn/log.log | grep -Eom 1 $ACCOUNT | grep -Eom 1 $ACCOUNT)"
	if [[ $ID -ge 1000 ]]; then
		if [[ -z $ONLINE ]]; then
			OFF=$((OFF+1))
		else
			ON=$((ON+1))
		fi
		fi
done < /etc/passwd


	

echo " ╭━━━━━━━━━━━━━╮
 ┣เช็คแบนวิทที่ใช้งานทั้งหมด
 ╰━━┳━━━━━━┳━━━╯
 ╭━━┻━━━━━━┻━━╮
 ┣1. รายชั่วโมง
 ┣2. รายวัน
 ┣3. รายสัปดาห์
 ┣4. รายเดือน
 ┣5. สิบวันก่อนหน้า
 ╰━━━━━━━━━━━━╯"
echo -e "  up/down ${GRAY}$TOTALBW${NC}${GRAY}B${NC}  |  กำลังเชื่อมต่อ ${GRAY}$ON${NC} บัญชี
"
read -p " ╰┫ เลือก ┣╯ : " opcao
else
opcao=$1
fi
case $opcao in
  01 | 1 )
  clear
 bwh;;
 02 | 2 )
 clear
vnstat -d ;;
 03 | 3 )
 clear
 vnstat -w;;
 04 | 4 )
 clear
vnstat -m ;;
 05 | 5 )
 clear
vnstat -t ;;
esac
echo " ╭━━━━━━━━━━━━━━━━━━╮
 ┣ http://plang-vpn.online/Line      
 ╰━━━━━━━━━━━━━━━━━━╯

"

