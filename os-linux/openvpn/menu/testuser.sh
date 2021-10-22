#!/bin/bash
#Script auto create trial Kguza SSH
#this user expire in 1 day
#Dev By Kguza
mkdir /home/vps/public_html/ovpn
Login=kguza_`</dev/urandom tr -dc 0-9 | head -c3`
Day="1"
Passwd=kguza_`</dev/urandom tr -dc 0-9 | head -c3`

useradd -e `date -d "$Day days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Passwd\n$Passwd\n"|passwd $Login &> /dev/null
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
payload=":1194@kguza.truevisions.tv.naver.jp 1194"
payload1="resolv-retry infinite"
;;
 2 | 02 )
sim="DTAC"
payload=":1194@beetalkmobile.com"
payload1="resolv-retry infinite"
;;
esac
IP=$(wget -qO- ipv4.icanhazip.com);
if [[ $1 == "" ]]
then
clear
cr
echo -e " "
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
DNS="VIP1"
DNSS="viber1.kguza.tk"
;;
2 | 02 )
DNS="VIP2"
DNSS="viber2.kguza.tk"
;;
3 | 03 )
DNS="VIP3"
DNSS="viber3.kguza.tk"
;;
4 | 04 )
DNS="TEST"
DNSS="test.truevisions.tv.viber.kguza.tk"
;;
5 | 05 )
DNS="IP_THE_ORIGINAL"
DNSS="$IP"
;;
esac
clear
echo ""
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈ 📥📥📥 openvpn:Account 📥📥📥"
echo " ┈╰┳━━━━━━━━━━━━━━━━━━━━━━━┳╯"
echo " ┈╭┻━━━━━━━━━━━━━━━━━━━━━━━┻╮"
echo " ┈┣ 》Host-IP  : $DNSS            "
echo " ┈┣ 》Username : $Login "
echo " ┈┣ 》Password : $Passwd   "
echo " ┈┣ 》Exp Date : $(date -d "$Day days" +"%d-%m-%Y")"
echo " ┈┣ 》Port default dropbear: 446,442         "
echo " ┈┣ 》Port default openSSH : 22         "
echo " ┈┣ 》Port default squid   : 8080,8000      "
echo " ┈┣ 》port ssl : 444   "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo ""
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣📥 Download File Config📥 "
echo " ┈┣━━━━━━━━━━━━━━━━━━━━━━━┫"
echo " ┈┣ http://$DNSS/$Login-$Passwd-$sim.ovpn"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
echo " "
cat > /home/vps/public_html/$Login-$Passwd-$sim.ovpn <<-END
client
dev tun
proto tcp
port 1194
route-method exe
nobind
persist-key
persist-tun
verb 2
cipher none
comp-lzo
<auth-user-pass>
$Login
$Passwd
</auth-user-pass>
remote $DNSS$payload
http-proxy $DNSS 8080
$payload1
http-proxy-option CUSTOM-HEADER X-Online-Host beetalkmobile.com

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
