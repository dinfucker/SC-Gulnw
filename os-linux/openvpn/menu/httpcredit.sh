clear
cr
if [[ $1 == "" ]]
then
echo ""
echo "  ┈╭━━━━━━━━━━━━━━━━━╮"
echo "  ┈┣ 💽💽 ใส่เครดิตแอพ http 💽💽"
echo "  ┈╰━┳━━━━━┳━━━━━━━━━╯"
echo "  ┈╭━┻━━━━━┻━━━━━━━━━╮"
echo "  ┈┣ 💽 1 : SSH-22-143"
echo "  ┈┣ 💽 2 : DROPBEAR"
echo "  ┈╰━━━━━━━━━━━━━━━━━╯"
read -p " ┈┣ พิมพ์เลข : " opcao
else
opcao=$1
fi
case $opcao in
 1)
clear
if [[ $1 == "" ]]
then
echo ""
echo " ┈╭━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 💾💾 ติดตั้ง credit ssl 💾💾"
echo " ┈╰━┳━━━━━┳━━━━━━━━━╯"
echo " ┈╭━┻━━━━━┻━━━━━━━━━╮"
echo " ┈┣ 💾 1 : ติดตั้งเครดิต"
echo " ┈┣ 💾 2 : แก้ไขเครดิต"
echo " ┈┣ 💾 3 : ลบเครดิต"
echo " ┈╰━━━━━━━━━━━━━━━━━╯"
echo ""
read -p " ┈┣ พิมพ์เลข : " opcao
else
opcao=$1
fi
case $opcao in
  1 | 01 )
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
nano /etc/bannerssh
service sshd restart;;
  2 | 02 )
nano /etc/bannerssh
service sshd restart;;
  3 | 03 )
echo 'Successfully deleted.' > /etc/bannerssh
service sshd restart;;
esac
  ;;
 2)
#!/bin/bash
clear
if [[ $1 == "" ]]
then
echo " ┈╭━━━━━━━━━━━━━━━━━╮"
echo " ┈┣ 💾💾 ติดตั้ง credit ssh 💾💾"
echo " ┈╰━┳━━━━━┳━━━━━━━━━╯"
echo " ┈╭━┻━━━━━┻━━━━━━━━━╮"
echo " ┈┣ 💾 1 : ติดตั้งเครดิต"
echo " ┈┣ 💾 2 : แก้ไขเครดิต"
echo " ┈┣ 💾 3 : ลบเครดิต"
echo " ┈╰━━━━━━━━━━━━━━━━━╯"
echo ""
read -p " ┈┣ พิมพ์เลข : " opcao
else
opcao=$1
fi
case $opcao in
  1 | 01 )
echo 'DROPBEAR_BANNER="/etc/issue.net"' >> /etc/default/dropbear
nano /etc/issue.net
/etc/init.d/dropbear restart;;
  2 | 02 )
nano /etc/issue.net
/etc/init.d/dropbear restart;;
  3 | 03 )
echo 'kguza' > /etc/issue.net
/etc/init.d/dropbear restart;;
esac
 ;;
esac