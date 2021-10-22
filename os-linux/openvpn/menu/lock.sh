#!/bin/bash
# Script unlock dropbear, webmin, squid3, openvpn, openssh
clear
cr
read -p " ┈┣ ชื่อที่ต้องการแบน : " Login
read -p " ┈┣ ยืนยัน Y/N :" selet
if [[ "$selet" = "Y" || "$selet" = "y" ]]; then
if usermod -L $Login > /dev/null 2>&1; then
clear
cr
echo " ┈╭━━━━━━━━━━━━━━━━━━━━━━╮"
echo " ┈┣  ชื่อ : $Login : 🔒🔒ถูกล็อคแล้ว🔒🔒 "
echo " ┈╰━━━━━━━━━━━━━━━━━━━━━━╯ "
exit
fi
clear
cr
echo ""
        echo " ┈╭━━━━━━━━━━━━━━━━╮
 ┈┣ ❎ ไม่พบชื่อผู้ใช้นี้ในระบบ ❎
 ┈╰━━━━━━━━━━━━━━━━╯"
echo ""
exit
fi

