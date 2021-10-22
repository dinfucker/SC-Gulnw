IP=`dig +short myip.opendns.com @resolver1.opendns.com`
  echo -e " "
  clear
  if [[ $1 == "" ]]
then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ⌨⌨สร้างไฟล์และลบไฟล์ ⌨⌨ "
echo " ┈┣━━━━━━━━━━┳━━━━━━━╯"
echo " ┈┣━━━━━━━━━━┻━━━━━━━╮"
echo " ┈┣ 🖲 1. สร้างไฟล์  "
echo " ┈┣━━━━━━━━━━┫"
echo " ┈┣ 🖲 2. ลบไฟล์   "
echo " ┈╰━━━━━━━━━━━━━━━━━━╯"
echo -e " "
read -p " ┈┣ พิมพ์เลข : " opcao
else
opcao=$1
fi
case $opcao in
 1 | 01 )
 clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ✏✏✏  สร้างไฟล์ ✏✏✏ "
echo " ┈╰━━━━━━━━━━━━━━━━━━╯ "
echo -e " "
printf " username : "; read user
if getent passwd $user > /dev/null 2>&1;
then
printf ""
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  ⛔⛔⛔  ยังไม่มีบัญชีผู้ใช้ ⛔⛔⛔ "
echo " ┈╰━━━━━━━━━━━━━━━━━━╯ "
echo -e " "
exit
fi
read -p " password : " passwd
echo -e "$passwd\n$passwd\n"|passwd $user &> /dev/null
clear
echo " "
if [[ $1 == "" ]]
then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈ 🔘🔘🔘 เลือกซิมการ์ดที่ต้องการใช้ 🔘🔘🔘"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo " ┈╭━━━━━━━━━━━┳━━━━━━━━━━╮"
echo " ┈┣ 📶📶 1 : TRUE               "
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 📶📶 2 : DTAC           "
echo " ┈╰━━━━━━━━━━━┻━━━━━━━━━━╯"
   echo -e " "
read -p "select : " opcao
else
opcao=$1
fi
case $opcao in
  1 | 01 )
sim="TRUE"
payload=":1194@kguza.truevisions.tv.naver.jp 1194"
payload1="resolv-retry infinite"
;;
 2 | 02 )
sim="DTAC"
payload1="resolv-retry infinite"
;;
esac
if [[ $1 == "" ]]
then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈ 🔘🔘🔘 เลือก dns หรือ IP 🔘🔘🔘"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo " ┈╭━━━━━━━━━━━┳━━━━━━━━━━╮"
echo " ┈┣ 🔖🔖 1 : VIP1               "
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🔖🔖 2 : VIP2           "
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🔖🔖 3 : VIP3               "
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🔖🔖 4 : TEST               "
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🔖🔖 5 : IP                "
echo " ┈╰━━━━━━━━━━━┻━━━━━━━━━━╯"
   echo -e " "
read -p "select : " opcao
else
opcao=$1
fi
case $opcao in
1 | 01 )
DNS="VIP1"
DNSS="vip1.viber.plang-vpn.online"
;;
2 | 02 )
DNS="VIP2"
DNSS="vip2.viber.plang-vpn.online"
;;
3 | 03 )
DNS="VIP3"
DNSS="vip3.viber.plang-vpn.online"
;;
4 | 04 )
DNS="TEST"
DNSS="test.truevisions.tv.viber.plang-vpn.online"
;;
5 | 05 )
DNS="IP_THE_ORIGINAL"
DNSS="$IP"
;;
esac
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈ 📥📥📥 openvpn:Account 📥📥📥"
echo " ┈╰┳━━━━━━━━━━━━━━━━━━━━━━━┳╯"
echo " ┈╭┻━━━━━━━━━━━━━━━━━━━━━━━┻╮"
echo " ┈┣ 》Host-IP  : $DNSS            "
echo " ┈┣ 》Username : $user "
echo " ┈┣ 》Password : $passwd   "
echo " ┈┣ 》Exp Date : $(date -d "$AKTIF days" +"%d-%m-%Y")"
echo " ┈┣ 》Port default dropbear: 22,80         "
echo " ┈┣ 》Port default openSSH : 443,143         "
echo " ┈┣ 》Port default squid   : 8080,8000      "
echo " ┈┣ 》port ssl : 444   "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo ""
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣📥 Download File Config📥 "
echo " ┈┣━━━━━━━━━━━━━━━━━━━━━━━┫"
echo " ┈┣ http://$DNSS:80/KGUZA-$sim.ovpn"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo " "
echo "
client
dev tun
proto tcp
port 1194
connect-retry 1
connect-timeout 120
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
persist-remote-ip
mute-replay-warnings
verb 2
cipher none
comp-lzo
script-security 3

<auth-user-pass>
$user
$passwd
</auth-user-pass>

remote $DNSS$payload
http-proxy $DNSS 8080
$payload1

http-proxy-option CUSTOM-HEADER X-Online-Host kguza.truevisions.tv

<ca>
$(cat /etc/openvpn/ca.pem)
</ca>" > /home/vps/public_html/KGUZA-$sim.ovpn;;
 2 | 02 )
 rm -r /home/vps/public_html
mkdir /home/vps/public_html
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━╮ "
echo " ┈┣  🕯🕯  ลบไฟล์เรียบร้อย 🕯🕯 "
echo " ┈╰━━━━━━━━━━━━━━━━━━╯ "
 echo -e " ";;
esac
 
