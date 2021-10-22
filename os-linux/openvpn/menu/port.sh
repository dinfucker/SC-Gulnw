clear
cr

if [ -e '/etc/openvpn/okport' ]; then
if [ -e '/var/lib/vnstat/eth0' ]; then
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o eth0 -j MASQUERADE
else
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o ens3 -j MASQUERADE
fi
iptables -I FORWARD -s 10.7.0.0/24 -j ACCEPT

IP=$(wget -qO- ipv4.icanhazip.com)
read -p " แก้ไอพีให้ถูกต้อง  : " -e -i $IP IP
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.7.0.0/24 -j SNAT --to-source $IP
iptables-save > /etc/iptables.conf
rm -r -f /etc/openvpn/okport
fi

echo "┈┣━━━━━━━━━━━━━━━━━━━━╮ 
┈┣ 🚫 คำเตือน 
┈┣ หากมีการเกิดปัญหาใดๆ ในการใช้คำสั่งนี้               
┈┣ ทางเราไม่รับผิดชอบปัญหาใดๆที่เกิดขึ้น                
┈┣━━━━━━━━━━━━━━━━━━━━╯       
┈╭━━━━━━━━━━━━━━━━━━━━╮  "
if [[ -e '/etc/openvpn/443' && -e '/etc/openvpn/1194' ]]; then
echo "┈┣ สถานะ ปัจจุบันเปิดพอต 1194 กับ 443       
┈┣ เลือกพอตที่ต้องการจะปิด
┈┣━━━━━━━━━━━━━━━━━━━━╯ 
┈┣ 1.  ปิดพอต 1194                      
┈┣ 2.  ปิดพอต  443                                       
┈┣ 3.  ยกเลิก                      "
read -p "┈╰━┫พิมพ์เลข   :  " selet
if [[ "$selet" = "1" ]]; then
clear
cr
rm -rf /etc/openvpn/1194
rm -f /etc/openvpn/1194.conf
service openvpn restart > /dev/null 2>&1
elif [[ "$selet" = "2" ]]; then
clear
cr
rm -rf /etc/openvpn/443
rm -f /etc/openvpn/443.conf
service openvpn restart > /dev/null 2>&1
fi
clear
cr
exit 
else
if [ -e '/etc/openvpn/1194.conf' ]; then 
echo "┈┣ สถานะ ปัจจุบันเปิดแค่พอต 1194
┈┣━━━━━━━━━━━━━━━━━━━━╯  "
read -p "┈╰┫ต้องการเปิดใช้งานพอต 443 ด้วยหรือไม่ Y/n :" selet
if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
cp /etc/openvpn/1194.conf /etc/openvpn/443.conf
sed -i 's/1194/443/g' /etc/openvpn/443.conf
sed -i 's/5555/3333/g' /etc/openvpn/443.conf
sed -i 's/10.8.0.0/10.7.0.0/g' /etc/openvpn/443.conf
mkdir -p /etc/openvpn/443
mkdir -p /etc/openvpn/1194
apt-get purge -y openvpn > /dev/null 2>&1
apt-get install -y openvpn > /dev/null 2>&1
service openvpn restart > /dev/null 2>&1
fi
clear
cr
else 
echo "┈┣ สถานะ ปัจจุบันเปิดแค่พอต 443
┈┣━━━━━━━━━━━━━━━━━━━━╯  "
read -p "┈╰┫ต้องการเปิดใช้งานพอต 1194 ด้วยหรือไม่ Y/n :" selet
if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
cp /etc/openvpn/443.conf /etc/openvpn/1194.conf
sed -i 's/443/1194/g' /etc/openvpn/1194.conf
sed -i 's/3333/5555/g' /etc/openvpn/1194.conf
sed -i 's/10.7.0.0/10.8.0.0/g' /etc/openvpn/1194.conf
mkdir -p /etc/openvpn/443
mkdir -p /etc/openvpn/1194
apt-get purge -y openvpn > /dev/null 2>&1
apt-get install -y openvpn > /dev/null 2>&1
service openvpn restart > /dev/null 2>&1
fi
clear
cr
fi
fi