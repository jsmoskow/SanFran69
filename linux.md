List recent security events
```
wtmp
who
last
lastlog
```

List network
connections and
related details
```
lsof –i
```
Look at scheduled jobs
```
less /etc/crontab,
ls /etc/cron.*,
ls /var/at/jobs
```
Check DNS settings
and the hosts file
```
less /etc/resolv.conf,
less /etc/hosts
```

Find recently‐modified files
```
ls –lat /
find / ‐mtime ‐2d ‐ls
```

Unusual Accounts

Look in /etc/passwd for new accounts in sorted list by
UID:
```
sort –nk3 –t: /etc/passwd | less
```

Normal accounts will be there, but look for new,
unexpected accounts, especially with UID < 500.
Also, look for unexpected UID 0 accounts:
```
 egrep ':0+:' /etc/passwd
``` 
On systems that use multiple authentication methods:
```
 getent passwd | egrep ':0+:'
```
Look for orphaned files, which could be a sign of an
attacker's temporary account that has been deleted.
```
find / -nouser -print
```

If you spot a process that is unfamiliar, investigate in
more detail using:
```
lsof –p [pid]
ps -eaf --forest
ls -al /proc/<PID>
```
This command shows all files and ports used by the
running process.

Look for unusual SUID root files:
```
find / -uid 0 –perm -4000 –print
```

Look for unusual large files (greater than 10
MegaBytes):
```
 find / -size +10000k –print
```

Look for files named with dots and spaces ("...", ".. ",
". ", and " ") used to camouflage files:
```
 find / -name " " –print
 find / -name ".. " –print
 find / -name ". " –print
 find / -name " " –print
```
Look for processes running out of or accessing files
that have been unlinked:
```
 lsof +L1
```

Unusual Scheduled Tasks

Look for unusual system-wide cron jobs:
```
 cat /etc/crontab
 ls /etc/cron.*
```