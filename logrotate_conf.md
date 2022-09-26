## Open the ```/etc/logrotate.d/syslog``` in editor  and modify to the below config   

```conf
/var/log/syslog
{
        rotate 4
        daily
        size 100M
        maxsize 100M
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                /usr/lib/rsyslog/rsyslog-rotate
        endscript
}
/var/log/mail.info
/var/log/mail.warn
/var/log/mail.err
/var/log/mail.log
/var/log/daemon.log
/var/log/kern.log
/var/log/auth.log
/var/log/user.log
/var/log/lpr.log
/var/log/cron.log
/var/log/debug
/var/log/messages
{
        rotate 4
        daily
        size 100M
        maxsize 100M
        missingok
        notifempty
        compress
        delaycompress
        sharedscripts
        postrotate
                /usr/lib/rsyslog/rsyslog-rotate
        endscript
}
```

## Move the logrotate job from daily cron to hourly cron 
```bash 
 mv  /etc/cron.daily/logrotate /etc/cron.hourly/. 
```
