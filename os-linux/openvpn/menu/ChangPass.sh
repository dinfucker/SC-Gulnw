#!/bin/bash
#By kguza
echo ""
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━╮"
echo " ┈  🛠🛠 แก้ไขชื่อและรหัสผ่าน 🛠🛠"
echo " ┈╰━━━━━━━━━━━━━━━━━╯"
echo " "
printf " ┣ ชื่อที่จะแก้ไข : "; read user
if cat /etc/passwd |grep $user: >/dev/null 2>/dev/null
then
printf ""
else
clear
cr
echo " ┈╭━━┳━━━━━━┳━━━╮"
echo " ┈  ❎❎ ไม่มีชื่อผู้ใช้นี้ ❎❎"
echo " ┈╰━━┻━━━━━━┻━━━╯"
exit
fi
printf " ┣ เปลี่ยนชื่อจาก $user เป็น :"; read nome
usermod -l $nome $user 1>/dev/null 2>/dev/null
read -p " ┣ รหัสผ่านใหม่ : " Passwd
echo -e "  "
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━╮"
echo " ┈  ชื่อเก่า $user เปลี่ยนเป็น $nome "
echo " ┈╰━┳┳━━━━━━━━━━━━━╯"
echo " ┈╭━┻┻━━━━━━━━━━━━━╮
 ┈  การเปลี่ยนแปลงเสร็จสมบูรณ์ 💯💯
 ┈╰━┳┳━━━━━━━━━━━━━╯"
echo " ┈╭━┻┻━━━━━━━━━━━━━╮"
echo " ┈┣Username : $nome "
echo " ┈┣━━━━━━━━━━━┫"
echo " ┈┣Password : $Passwd   "
echo " ┈╰━━━━━━━━━━━━━━━━╯"
echo -e " "
echo -e "$Passwd\n$Passwd\n"|passwd $nome &> /dev/null
IP=`dig +short myip.opendns.com @resolver1.opendns.com`

