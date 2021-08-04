# lsblk

- 列出磁盘及其挂载情况

```shell
[gopeslapp1@GOAZEPLAP0097 ~]$ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
fd0       2:0    1    4K  0 disk
sda       8:0    0  127G  0 disk
├─sda1    8:1    0  500M  0 part /boot
├─sda2    8:2    0   50G  0 part /
├─sda3    8:3    0   10G  0 part /tmp
├─sda4    8:4    0    1K  0 part
├─sda5    8:5    0   15G  0 part /var
├─sda6    8:6    0   15G  0 part /var/log
├─sda7    8:7    0    5G  0 part /var/log/audit
├─sda8    8:8    0    8G  0 part /var/tmp
├─sda9    8:9    0   10G  0 part /home
├─sda10   8:10   0  4.7G  0 part /opt/IBM
└─sda11   8:11   0    8G  0 part /housekeep
sdb       8:16   0  256G  0 disk
└─sdb1    8:17   0  256G  0 part /mnt/resource
sdc       8:32   0    1T  0 disk
sdd       8:48   0    4T  0 disk
```