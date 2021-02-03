## Setup DNS  properly for in /etc/dhcpcd.conf

## Setup /etc/systemd/timesyncd.conf
```
[Time]
Servers=your.time.server  0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org 3.debian.pool.ntp.org
```

## Add your.time.server to /etc/ntp.conf 

```
 sudo nano /etc/ntp.conf 
```
and the add the below line 
```
server your.time.server  iburst
```
## Disable RTC
```
sudo timedatectl set-local-rtc 0
```
OR 
```
sudo timedatectl set-local-rtc false
```

## Enable NTP
```
sudo timedatectl set-ntp 1 
```
OR
```
sudo timedatectl set-ntp true
```

## Check the timedatectl 
```
timedatectl 
```

## Restart the NTP Service
```
sudo systemctl restart ntp
```
and check the status with following command 
```
sudo systemctl status 
```
## Restart the systemd-timesyncd service
```
sudo systemctl restart  systemd-timesyncd.service
```
and check the status with following command 
```
sudo systemctl status  systemd-timesyncd.service
```
## Check the timedatectl 
```
timedatectl 
```
