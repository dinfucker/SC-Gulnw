#!/bin/bash
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 💾💾 สำรองชื่อผู้ใช้ และ คืนค่าชื่อผู้ใช้ 💾💾"
echo " ┈╰━━━┳━━━━━━━━━━━┳━━━━━━╯"
echo " ┈╭━━━┻━━━━━━━━━━━┻━━━━━━╮"
echo " ┈┃ 🔖ใส่ตัวเลขแล้วกด 🖲 ENTER🖲 "
echo " ┈┣━━━━━━━━━━━━━━━━━━━━━━╯"
echo " ┈┣ 📥 0. Backup"
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 📥 1. Restore Dns vip1"
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 📥 2. Restore Dns vip2"
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 📥 3. Restore Dns vip3"
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 📥 4. Restore Dns vip4"
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 📥 5. Restore Dns vip5"
echo " ┈┣━━━━━━━━━━━━━━━┫"
echo " ┈┣ 📥 6. Restore IP"
echo " ┈┣━━━━━━━━━━━━━━━━━━━━━━╯"
read -p " ┈┣ พิมพ์เลข : " opcao
if [[ $opcao = "0" || $opcao = "1" || $opcao = "2" || $opcao = "3" || $opcao = "4" || $opcao = "5" || $opcao = "6" ]]; then

case $opcao in
0 | 00 )
tar cf /home/vps/public_html/user.tar /etc/passwd /etc/shadow /etc/gshadow /etc/group
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 📥 แบ็คอับเสร็จเรียบร้อย 📥 "
echo " ┈╰━━━━━━━━━━━━━━━━━╯"
exit
;;
1 | 01 )
 dns1=vip1
 dns=viber1.kguza.net
;;
2 | 02 )
 dns1=vip2
 dns=viber2.kguza.net
;;
3 | 03 )
 dns1=vip3
 dns=viber3.kguza.net
;;
4 | 04 )
 dns1=vip4
 dns=viber4.kguza.net
;;
5 | 05 )
 dns1=vip5
 dns=viber5.kguza.net
;;
6 | 06 )
read -p " ┣ ใส่ไอพีเก่าที่แบ็คอับใว้  " dns2
read -p " ┣ ยืนยันไอพี $dns2 คือเซิร์ฟเวอร์ที่จะย้ายมา Y/N : " confirm
if [[ y = $confirm || Y = $confirm ]]; then
cd /
wget -q "http://$dns2/user.tar"
if [ -e '/user.tar' ]; then
tar xf user.tar
rm user.tar
echo news:vpnk | chpasswd
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 🗳 คืนค่าผู้ใช้ของไอพี $dns2 เสร็จเรียบร้อย "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 🚨 ไม่พบไฟล์คืนค่าผู้ใช้ของไอพี $dns2 "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
fi
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ⛔ ยกเลิกคืนค่าผู้ใช้ของไอพี $dns2 "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
fi
;;
esac
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ⛔ โปรดใช้คำสั่งที่ถูกต้อง "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
fi

if [[ $opcao = "0" || $opcao = "1" || $opcao = "2" || $opcao = "3" || $opcao = "4" || $opcao = "5" || $opcao = "6" ]]; then
read -p " ┣ จะแก้ไขหรือไม่  " -e -i $dns dns2
read -p " ┣ ต้องการคืนค่า $dns1 หรือไม่ Y/N : " confirm
if [[ y = $confirm || Y = $confirm ]]; then
cd /
wget -q "http://$dns2/user.tar"
if [ -e '/user.tar' ]; then
tar xf user.tar
rm user.tar
echo news:Kguza | chpasswd
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 🗳 คืนค่าผู้ใช้ $dns1 เสร็จเรียบร้อย "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ⛔ ไม่พบไฟล์คืนค่าผู้ใช้ของ $dns1 "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
fi
else
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ ⛔ ยกเลิกคืนค่าผู้ใช้เซิฟร์ $dns1 "
echo " ┈╰━━━━━━━━━━━━━━━━━━━╯"
exit
fi
fi
