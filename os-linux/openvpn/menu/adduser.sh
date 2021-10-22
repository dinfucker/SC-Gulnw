#!/bin/bash
clear
cr
echo " "
echo " ┈╭━━━━━━━━━━━━━━━━━╮"
echo " ┈ ✏✏✏ สร้างบัญชีผู้ใช้vpn ✏✏✏"
echo " ┈╰━━━━━━━━━━━━━━━━━╯"
 echo " "
read -p " ชื่อผู้ใช้ : " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
echo ""
clear
cr
echo " ┈╭━━┳━━━━━━┳━━━╮"
echo " ┈  ❎❎ มีชื่อผู้ใช้นี้แล้ว ❎❎"
echo " ┈╰━━┻━━━━━━┻━━━╯"
	echo -e " "
	exit 1
else
	read -p " รหัสผ่าน : " password
	read -p " จำนวนวันใช้งาน : " AKTIF

	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
	clear
if [[ $1 == "" ]]
then
clear
echo " "
echo -e " "
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
read -p "พิมพ์ตัวเลข : " opcao
else
opcao=$1
fi
case $opcao in
  1 | 01 )
sim="TRUE"
payload=":443@connect.facebook.net"
payload1="http-proxy-option CUSTOM-HEADER Host connect.facebook.net"
;;
 2 | 02 )
sim="DTAC"
payload=":443@beetalkmobile.com"
payload1="http-proxy-option CUSTOM-HEADER Host beetalkmobile.com"
;;
esac
clear
IP=$(wget -qO- ipv4.icanhazip.com);
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
read -p "พิมพ์ตัวเลข : " opcao
else
opcao=$1
fi
case $opcao in
1 | 01 )
DNS="free1"
DNSS="server.one.kguza.online"
;;
2 | 02 )
DNS="free2"
DNSS="server.two.kguza.online"
;;
3 | 03 )
DNS="Vip1"
DNSS="server.vip.kguza.online"
;;
4 | 04 )
DNS="TEST"
DNSS="server.test.kguza.online"
;;
5 | 05 )
DNS="IP_THE_ORIGINAL"
DNSS="$IP"
;;
esac
clear
cr
echo ""
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈ 📥📥📥 openvpn:Account 📥📥📥"
echo " ┈╰┳━━━━━━━━━━━━━━━━━━━━━━━┳╯"
echo " ┈╭┻━━━━━━━━━━━━━━━━━━━━━━━┻╮"
echo " ┈┣ 》Host-IP  : $DNSS            "
echo " ┈┣ 》Username : $username "
echo " ┈┣ 》Password : $password   "
echo " ┈┣ 》Exp Date : $(date -d "$AKTIF days" +"%d-%m-%Y")"
echo " ┈┣ 》Port default dropbear: 446,442         "
echo " ┈┣ 》Port default openSSH : 22         "
echo " ┈┣ 》Port default squid   : 8080      "
echo " ┈┣ 》port ssl : 444   "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo ""
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣📥 Download File Config📥 "
echo " ┈┣━━━━━━━━━━━━━━━━━━━━━━━┫"
echo " ┈┣ http://$DNSS/$username-$password-$sim.ovpn"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo " "
cat > /home/vps/public_html/$username-$password-$sim.ovpn <<-END
client
dev tun
proto tcp
port 443
route-method exe
nobind
persist-key
persist-tun
verb 2
cipher none
comp-lzo
<auth-user-pass>
$username
$password
</auth-user-pass>
remote $DNSS$payload
http-proxy $DNSS 8080
$payload1

<ca>
$(cat /etc/openvpn/ca.pem)
</ca>
<key>
$(cat /etc/openvpn/client-key.pem)
</key>
<cert>
$(cat /etc/openvpn/client-cert.pem)
</cert>
#Kguza vpn free
END
fi