#!/bin/bash
clear
cr
echo " ┈╭━━━━━━━━━━━━━━╮"
echo " ┈ 🔗🔗 ต่ออายุบัญชีผู้ใช้งาน 🔗🔗"
echo " ┈╰━━━━━━━━━━━━━━╯"
echo " "
printf " ใส่ชื่อที่จะต่ออายุ : "; read user
if getent passwd $user > /dev/null 2>&1;
then
printf ""
else
clear
cr
echo " "
echo -e " "
echo " ┈╭━━┳━━━━━━┳━━━╮"
echo " ┈  ❎❎ ยังไม่มีบัญชีผู้ใช้ ❎❎"
echo " ┈╰━━┻━━━━━━┻━━━╯"
echo -e " "
exit
fi
clear
echo " "
echo " ┈╭━━━━━━━━━━━━━━╮"
echo " ┈ 📆📆 กำหนดวันหมดอายุ 📆📆"
echo " ┈╰━━━━━━━━━━━━━━╯"
echo " "
read -p " ตัวอย่าง 2018/12/31 : " date
chage -E $date $user 2> /dev/null
clear
cr
echo " ┈╭━━━━━━━━━━━━━━╮"
echo " ┈ 🕰🕰 ต่ออายุเรียบร้อยแล้ว 🕰🕰"
echo " ┈╰━┳━━━━┳━━━━━━━╯"
echo " ┈╭━┻━━━━┻━━━━━━━╮"
echo " ┈ ✏✏ ชื่อที่ต่ออายุ : $user "
echo " ┈╰━┳━━━━┳━━━━━━━╯"
echo " ┈╭━┻━━━━┻━━━━━━━━━━━━━╮"
echo " ┈ 📆 กำหนดวันหมดอายุเป็น $date 📆"
echo " ┈╰━━━━━━━━━━━━━━━━━━━━╯"
echo -e " "