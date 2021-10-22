#!/bin/bash

clear
cr
if [[ $1 == "" ]]
then
clear
cr
echo -e " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo -e " ┈┣ ⛽⛽⛽ จัดการวันใช้งานผู้ใช้ ⛽⛽⛽  "
echo -e " ┈╰━┳━━━┳━━━━━━━━━━━━━━━━╯"
echo -e " ┈╭━┻━━━┻━━━━━━━━━━━━━━━━╮"
echo -e " ┈┣ 🖲🖲 1 : ดูผู้ใช้ที่หมดอายุ           "
echo " ┈┣━━━━━━━━━━━━━━┫"
echo -e " ┈┣ 🖲🖲 2 : ลบผู้ใช้ที่หมดอายุ"
echo -e " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo -e " "
read -p " ┈┣ พิมพ์เลข : " opcao
else
opcao=$1
fi
case $opcao in
 1 | 01 )
 clear
 cr
echo -e " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo -e " ┈┣ 📵📵📵 ผู้ใช้ที่หมดอายุ 📵📵📵   "
echo -e " ┈╰━┳━━━┳━━━━━━━━━━━━━━━━╯"
echo -e " ┈╭━┻━━━┻━━━━━━━━━━━━┫"
datahoje=$(date +%s)
for user in $(cat /etc/passwd |grep -v "nobody" |awk -F : '$3 > 900 {print $1}')
do
dataexp=$(chage -l $user |grep "Account expires" |awk -F : '{print $2}')
if [[ $dataexp == ' never' ]]; then
id > /dev/null 2>/dev/null
else
dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
dataexpnum=$(date '+%s' -d"$dataexp")
fi
if [[ $dataexpnum < $datahoje ]]; then

echo " ┈┣ 🗑ชื่อผู้ใช้ $user "
echo " ┈┣ 🗑หมดอายุ $dataexpn "
echo " ┈┣━━━━━━━━━━━━━━━━━━┫"
else
echo " " > /home/.xxx
fi
done
echo -e " "
exit;;
 2 | 02 )
 clear
cr
echo -e " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo -e " ┈┣ ❌❌ ลบผู้ใช้ที่หมดอายุเรียบร้อย ❌❌   "
echo -e " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo -e " ┈╭━┻━━━┻━━━━━━━━━━━━┫"
datahoje=$(date +%s)
for user in $(cat /etc/passwd |grep -v "nobody" |awk -F : '$3 > 900 {print $1}')
do
dataexp=$(chage -l $user |grep "Account expires" |awk -F : '{print $2}')
if [[ $dataexp == ' never' ]]; then
id > /dev/null 2>/dev/null
else
dataexpn=$(date -d"$dataexp" '+%d/%m/%Y')
dataexpnum=$(date '+%s' -d"$dataexp")
fi
if [[ $dataexpnum < $datahoje ]]; then
echo " ┈┣ $user ถูกลบแล้ว 🗑🗑"
echo " ┈┣━━━━━━━━━━━━━━━━━━┫"
kill $(ps -u $user |awk '{print $1}') >/dev/null 2>/dev/null ; userdel $user
else
echo " " > /home/.xxx
fi
done
echo -e " "
exit;;
esac
clear
cr
 echo -e " "
echo -e " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo -e " ┈┣ 🔎🔎 ไม่มีตัวเลือกที่คุณพิมพ์ 🔎🔎"
echo -e " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯"
echo -e " "

