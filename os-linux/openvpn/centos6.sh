#!/bin/bash
#Web Panel
#<BODY text='ffffff'>
# Mod by kguza
#!/bin/bash
#Requirement
rm -f install
if [ ! -e /usr/bin/curl ]; then
   yum -y update && yum -y upgrade
   yum -y install curl
fi

# initializing var
OS=`uname -m`;
MYIP=$(curl -4 icanhazip.com)
if [ $MYIP = "" ]; then
   MYIP=`ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1`;
fi
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

# disable se linux
echo 0 > /selinux/enforce
sed -i 's/SELINUX=enforcing/SELINUX=disable/g'  /etc/sysconfig/selinux

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service sshd restart

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.d/rc.local

#Add DNS Server ipv4
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
sed -i '$ i\echo "nameserver 8.8.8.8" > /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.4.4" >> /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.8.8" > /etc/resolv.conf' /etc/rc.d/rc.local
sed -i '$ i\echo "nameserver 8.8.4.4" >> /etc/resolv.conf' /etc/rc.d/rc.local

# install wget and curl
yum -y install wget curl

kguza="http://kguza.net/scrip/u-d/openvpn"
cd /usr/bin
cd
wget -q -O menu "$kguza/menu/menu"
chmod +x menu
./menu
rm -f menu
wget -q -O /usr/bin/bwh "$kguza/menu/bwh"
chmod +x /usr/bin/bwh


cd
# setting repo
wget $kguza/conf/centos6/epel-release-6-8.noarch.rpm
wget $kguza/conf/centos6/remi-release-6.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
rpm -Uvh remi-release-6.rpm

if [ "$OS" == "x86_64" ]; then
  wget $kguza/conf/centos6/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
  rpm -Uvh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
else
  wget $kguza/conf/centos6/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
  rpm -Uvh rpmforge-release-0.5.3-1.el6.rf.i686.rpm
fi

sed -i 's/enabled = 1/enabled = 0/g' /etc/yum.repos.d/rpmforge.repo
sed -i -e "/^\[remi\]/,/^\[.*\]/ s|^\(enabled[ \t]*=[ \t]*0\\)|enabled=1|" /etc/yum.repos.d/remi.repo
rm -f *.rpm

# remove unused
yum -y remove sendmail;
yum -y remove httpd;
yum -y remove cyrus-sasl

# update
yum -y update

echo news:vpnk | chpasswd
# install webserver
yum -y install nginx php-fpm php-cli
service nginx restart
service php-fpm restart
chkconfig nginx on
chkconfig php-fpm on

# install essential package
yum -y install wondershaper rrdtool screen iftop htop nmap bc nethogs openvpn vnstat ngrep mtr git zsh mrtg unrar rsyslog rkhunter mrtg net-snmp net-snmp-utils expect nano bind-utils
yum -y groupinstall 'Development Tools'
yum -y install cmake

yum -y --enablerepo=rpmforge install axel sslh ptunnel unrar

# disable exim
service exim stop
chkconfig exim off

# setting vnstat
vnstat -u -i eth0
echo "MAILTO=root" > /etc/cron.d/vnstat
echo "*/5 * * * * root /usr/sbin/vnstat.cron" >> /etc/cron.d/vnstat
echo "30 3 * * * root /sbin/reboot" > /etc/cron.d/reboot
service vnstat restart
chkconfig vnstat on

# install screenfetch
cd
wget -q http://kguza.net/scrip/u-d/openvpn/menu/screenfetch-dev
mv screenfetch-dev /usr/bin/screenfetch
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch" >> .profile
echo "clear" >> .bashrc
echo "screenfetch" >> .bashrc

# install webserver
cd
yum -y install nginx
cat > /etc/nginx/nginx.conf <<END3
user www-data;

worker_processes 1;
pid /var/run/nginx.pid;

events {
	multi_accept on;
  worker_connections 1024;
}

http {
	gzip on;
	gzip_vary on;
	gzip_comp_level 5;
	gzip_types    text/plain application/x-javascript text/xml text/css;

	autoindex on;
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  server_tokens off;
  include /etc/nginx/mime.types;
  default_type application/octet-stream;
  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;
  client_max_body_size 32M;
	client_header_buffer_size 8m;
	large_client_heade#!/bin/bash
#Web Panel
#<BODY text='ffffff'>
# Mod by kguza
#!/bin/bash
#Requirement
rm -f install
if [ ! -e /usr/bin/curl ]; then
   yum -y update && yum -y upgrade
   yum -y install curl
fi

# initializing var
OS=`uname -m`;
MYIP=$(curl -4 icanhazip.com)
if [ $MYIP = "" ]; then
   MYIP=`ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1`;
fi
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

# disable se linux
echo 0 > /selinux/enforce
sed -i 's/SELINUX=enforcing/SELINUX=disable/g'  /etc/sysconfig/selinux

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service sshd restart

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.d/rc.local

#Add DNS Server ipv4
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
sed -i '$ i\echo "nameserver 8.8.8.8" > /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.4.4" >> /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.8.8" > /etc/resolv.conf' /etc/rc.d/rc.local
sed -i '$ i\echo "nameserver 8.8.4.4" >> /etc/resolv.conf' /etc/rc.d/rc.local

# install wget and curl
yum -y install wget curl

kguza="http://kguza.net/scrip/u-d/openvpn"
cd /usr/bin
cd
wget -q -O menu "$kguza/menu/menu"
chmod +x menu
./menu
rm -f menu
wget -q -O /usr/bin/bwh "$kguza/menu/bwh"
chmod +x /usr/bin/bwh


cd
# setting repo
wget $kguza/conf/centos6/epel-release-6-8.noarch.rpm
wget $kguza/conf/centos6/remi-release-6.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
rpm -Uvh remi-release-6.rpm

if [ "$OS" == "x86_64" ]; then
  wget $kguza/conf/centos6/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
  rpm -Uvh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
else
  wget $kguza/conf/centos6/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
  rpm -Uvh rpmforge-release-0.5.3-1.el6.rf.i686.rpm
fi

sed -i 's/enabled = 1/enabled = 0/g' /etc/yum.repos.d/rpmforge.repo
sed -i -e "/^\[remi\]/,/^\[.*\]/ s|^\(enabled[ \t]*=[ \t]*0\\)|enabled=1|" /etc/yum.repos.d/remi.repo
rm -f *.rpm

# remove unused
yum -y remove sendmail;
yum -y remove httpd;
yum -y remove cyrus-sasl

# update
yum -y update

echo news:vpnk | chpasswd
# install webserver
yum -y install nginx php-fpm php-cli
service nginx restart
service php-fpm restart
chkconfig nginx on
chkconfig php-fpm on

# install essential package
yum -y install wondershaper rrdtool screen iftop htop nmap bc nethogs openvpn vnstat ngrep mtr git zsh mrtg unrar rsyslog rkhunter mrtg net-snmp net-snmp-utils expect nano bind-utils
yum -y groupinstall 'Development Tools'
yum -y install cmake

yum -y --enablerepo=rpmforge install axel sslh ptunnel unrar

# disable exim
service exim stop
chkconfig exim off

# setting vnstat
vnstat -u -i eth0
echo "MAILTO=root" > /etc/cron.d/vnstat
echo "*/5 * * * * root /usr/sbin/vnstat.cron" >> /etc/cron.d/vnstat
echo "30 3 * * * root /sbin/reboot" > /etc/cron.d/reboot
service vnstat restart
chkconfig vnstat on

# install screenfetch
cd
wget -q http://kguza.net/scrip/u-d/openvpn/menu/screenfetch-dev
mv screenfetch-dev /usr/bin/screenfetch
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch" >> .profile
echo "clear" >> .bashrc
echo "screenfetch" >> .bashrc

# install webserver
cd
yum -y install nginx
cat > /etc/nginx/nginx.conf <<END3
user www-data;

worker_processes 1;
pid /var/run/nginx.pid;

events {
	multi_accept on;
  worker_connections 1024;
}

http {
	gzip on;
	gzip_vary on;
	gzip_comp_level 5;
	gzip_types    text/plain application/x-javascript text/xml text/css;

	autoindex on;
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  server_tokens off;
  include /etc/nginx/mime.types;
  default_type application/octet-stream;
  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;
  client_max_body_size 32M;
	client_header_buffer_size 8m;
	large_client_header_buffers 8 8m;

	fastcgi_buffer_size 8m;
	fastcgi_buffers 8 8m;

	fastcgi_read_timeout 600;

  include /etc/nginx/conf.d/*.conf;
}
END3
sed -i 's/www-data/nginx/g' /etc/nginx/nginx.conf
mkdir -p /home/vps/public_html/open-on
wget -q -O /home/vps/public_html/open-on/index.php "$kguza/conf/api.txt"
wget -q -O /home/vps/public_html/index.html "$kguza/conf/kguza-vpn.txt"
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
rm /etc/nginx/conf.d/*
args='$args'
uri='$uri'
document_root='$document_root'
fastcgi_script_name='$fastcgi_script_name'
cat > /etc/nginx/conf.d/vps.conf <<END4
server {
  listen       80;
  server_name  127.0.0.1 localhost;
  access_log /var/log/nginx/vps-access.log;
  error_log /var/log/nginx/vps-error.log error;
  root   /home/vps/public_html;

  location / {
    index  index.html index.htm index.php;
    try_files $uri $uri/ /index.php?$args;
  }

  location ~ \.php$ {
    include /etc/nginx/fastcgi_params;
    fastcgi_pass  127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
  }
}

END4
sed -i 's/apache/nginx/g' /etc/php-fpm.d/www.conf
chmod -R +rx /home/vps
service php-fpm restart
service nginx restart

# install openvpn
cd /
wget -q -O ovpn.tar "$kguza/conf/openvpn.tar"
tar xf ovpn.tar
rm ovpn.tar

cat > /etc/openvpn/KGUZA.ovpn <<EOF1
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

auth-user-pass 

remote $MYIP
http-proxy $MYIP 8080

<ca>
$(cat /etc/openvpn/ca.pem)
</ca>
EOF1

cat > /etc/openvpn/client.ovpn << KGUZA
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

auth-user-pass 

remote $MYIP
http-proxy $MYIP 8080

<ca>
$(cat /etc/openvpn/ca.pem)
</ca>
KGUZA

wget -O /etc/openvpn/KGUZA.conf $kguza/conf/centos6/1194-centos.conf
if [ "$OS" == "x86_64" ]; then
  wget -O /etc/openvpn/KGUZA.conf  $kguza/conf/centos6/1194-centos64.conf
fi
wget -O /etc/iptables.up.rules $kguza/conf/centos6/iptables.up.rules
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.d/rc.local
MYIP=`dig +short myip.opendns.com @resolver1.opendns.com`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/iptables.up.rules;
sed -i 's/venet0/eth0/g' /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
service openvpn restart
chkconfig openvpn on
cd


cd

#install PPTP
cd
yum -y install pptpd
cat > /etc/ppp/pptpd-options <<END
name pptpd
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
require-mppe-128
ms-dns 8.8.8.8
ms-dns 8.8.4.4
proxyarp
nodefaultroute
lock
nobsdcomp
END
echo "option /etc/ppp/pptpd-options" > /etc/pptpd.conf
echo "logwtmp" >> /etc/pptpd.conf
echo "localip 10.1.0.1" >> /etc/pptpd.conf
echo "remoteip 10.1.0.5-100" >> /etc/pptpd.conf
cat >> /etc/ppp/ip-up <<END
ifconfig ppp0 mtu 1400
END
mkdir /var/lib/premium-script
/etc/init.d/pptpd restart
chkconfig pptpd on
mkdir -p /etc/pptpd
# install badvpn
wget -O /usr/bin/badvpn-udpgw $kguza/conf/centos6/badvpn-udpgw
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw $kguza/conf/centos6/badvpn-udpgw64
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.d/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

cd

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i '/Port 22/a Port  90' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port  22/g' /etc/ssh/sshd_config
service sshd restart
chkconfig sshd on

# install dropbear
yum -y install dropbear
echo "OPTIONS=\"-p 109 -p 110 -p 442\"" > /etc/sysconfig/dropbear
echo "/bin/false" >> /etc/shells
service dropbear restart
chkconfig dropbear on

# install vnstat gui
cd /home/vps/public_html/
wget $kguza/conf/centos6/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
cd

# install fail2ban
yum -y install fail2ban
service fail2ban restart
chkconfig fail2ban on

# install squid
yum -y install squid
cat > /etc/squid/squid.conf <<-END
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl localnet src fc00::/7
acl localnet src fe80::/10
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/32
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localnet
http_access allow localhost
http_access deny all
http_port 8080
http_port 3128
hierarchy_stoplist cgi-bin ?
coredump_dir /var/spool/squid
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname Daybreakersx
END
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
chkconfig squid on

# install stunnel
yum install stunnel
cat /etc/openvpn/client-key.pem /etc/openvpn/client-cert.pem > /etc/pki/tls/certs/stunnel.pem
wget -O /etc/stunnel/stunnel.conf $kguza/conf/centos6/stunnel.conf
mkdir /var/run/stunnel
chown nobody:nobody /var/run/stunnel
stunnel /etc/stunnel/stunnel.conf

# Setting IPtables
cat > /etc/iptables.up.rules <<-END
*filter
:FORWARD ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p tcp -m tcp --dport 81 -m state --state NEW -j ACCEPT
-A INPUT -p udp -m udp --dport 81 -m state --state NEW -j ACCEPT
-A FORWARD -i eth0 -o ppp0 -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i ppp0 -o eth0 -j ACCEPT
COMMIT

*nat
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o eth0 -j MASQUERADE
-A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
-A POSTROUTING -s 10.1.0.0/24 -o eth0 -j MASQUERADE
COMMIT
END
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.d/rc.local;
iptables-restore < /etc/iptables.up.rules;

rm -f /etc/sysconfig/iptables;

cp /etc/iptables.up.rules /etc/sysconfig/iptables;

chkconfig iptables off;

service iptables restart;

chkconfig iptables on;

service iptables save;

# install bmon
yum -y install bmon

# download script
cd
#wget https://raw.githubusercontent.com/daybreakersx/premscript/master/install-premiumscript.sh -O - -o /dev/null|sh

# cron
service crond start
chkconfig crond on

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# finalizing
chown -R nginx:nginx /home/vps/public_html
service nginx start
service php-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service sshd restart
service dropbear restart
service fail2ban restart
service squid restart
service webmin restart
service pptpd restart
service crond start
chkconfig crond on
service pptpd restart

#clearing history
history -c

mv /etc/openvpn/KGUZA.ovpn /home/vps/public_html/KGUZA.ovpn

# info
cr
echo " "
echo "  Download File Config "
echo "  http://$MYIP/KGUZA.ovpn"
echo " "
history -c