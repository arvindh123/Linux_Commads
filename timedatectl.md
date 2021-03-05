sudo nano /etc/dhcpcd.conf   
static domain_name_servers=10.0.0.10 10.255.255.10   
sudo systemctl restart dhcpcd   
sudo nano /etc/systemd/timesyncd.conf   
ip-of-ntp-server  
sudo nano /etc/ntp.conf   
server ip-of-ntp-server  iburst  
sudo timedatectl set-local-rtc 0  
sudo timedatectl set-local-rtc false  
sudo timedatectl set-ntp 1   
sudo timedatectl set-ntp true  
sudo systemctl restart ntp  
sudo systemctl status ntp   
sudo systemctl restart  systemd-timesyncd.service  
sudo systemctl status  systemd-timesyncd.service  
sudo timedatectl  
 
