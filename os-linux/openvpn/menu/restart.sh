#!/bin/bash
clear
  cr
if [[ $1 == "" ]]
then
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 🔋🔋🔋 รีสตาร์ตระบบต่างๆ 🔋🔋🔋"
echo " ┈┣━━━┳━━━━━┳━━━━━━━━━━━━╯"
echo " ┈┣━━━┻━━━━━┻━━━━━━━━━━━━╮"
echo " ┈┣ 🚀1. dropbear"
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🚀2. nginx"
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🚀3. php5-fpm"
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🚀4. webmin"
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🚀5. squid3"
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🚀6. openvpn"
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣ 🚀7. ssh"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo ""
read -p " ┣ พิมพ์เลข : " opcao
else
opcao=$1
fi
case $opcao in
 1 )
service dropbear restart
;;
2 )
service nginx restart
;;
3 )
service php5-fpm restart
;;
4 )
service webmin restart
;;
5 )
service squid3 restart
;;
6 )
service openvpn restart
;;
7 )
service ssh restart
;;
esac
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈  🌜🌜 การเปลี่ยนแปลงเสร็จสมบูรณ์ 🌛🌛"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo " "


