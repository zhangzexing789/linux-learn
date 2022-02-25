# mount new disk

## 磁盘分区信息存储的两种形式

常见磁盘分区存储形式类型有两种：MBR(MSDOS) 和 GPT

## MBR
MBR(Master Boot Record，主引导记录）。
MBR 是存在于驱动器最开始部分的一个特殊的启动扇区，一般叫它 0 扇区。它由 446B 的启动加载器（Windows 和 Linux 的不同），64B 的分区表，和 2B 用来存放区域的有效性标识 55AA，共 512B。
> MBR 分区最大只支持 2T
分区表每 16B 标识一个分区，包括分区的活动状态标志、文件系统标识、起止柱面号、磁头号、扇区号、隐含扇区数目 (4 个字节)、分区总扇区数目(4 个字节) 等信息。
分区总扇区数目决定了这一分区的大小，一个扇区一般 512B，所以 4 个字节，32 位所能表示的最大扇区数为 2 的 32 次方，也就决定了一个分区的大小最大为 2T（ 2**32 * 512 / 1024 / 1024 / 1024 /1024）。
> MBR 只支持最多 4 个主分区
16B 标识一个分区，64B 就一共只能有 4 个分区，所以主分区最多只能有 4 个。一块磁盘如果要分多于 4 个分区，必须要分一个扩展分区，然后在扩展分区中再去划分逻辑分区。

## GPT
GPT(GUID Partition Table)，这是最近几年逐渐流行起来的一种分区形式，如果要将使用 GPT 分区格式的磁盘作为系统盘，需要 UEFI BIOS 的支持，它才可以引导系统启动。UEFI 一种称为 Unified Extensible Firmware Interface(统一的可扩展的固件接口，它最终是为了取代 BIOS，目前市面上的 BIOS 大多已支持 UEFI。GPT 也是为了最终取代 MBR 的。

## GPT 相比 MBR 的优点

- 分区容量可以大于 2T
- 可以支持无限个主分区
- 更为健壮。MBR 中分区信息和启动信息保存在一起而且只有一份，GPT 在整个磁盘上保存多份这个信息，并为它们提供 CRC 检验，当有数据损坏时，它能够进行恢复。


## 检查磁盘挂载情况

```
ls -al /dev/disk/by-uuid/
```

## mount new disk less than 2T
```shell
[user01@host01 ~]$ sudo fdisk /dev/sdc #
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xd2c4a3c5.

The device presents a logical sector size that is smaller than
the physical sector size. Aligning to a physical sector (or optimal
I/O) size boundary is recommended, or performance may be impacted.

Command (m for help): m #查看命令帮助
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   g   create a new empty GPT partition table
   G   create an IRIX (SGI) partition table
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)

Command (m for help): n #添加新分区，并开始分区操作
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p):
Using default response p
Partition number (1-4, default 1):
First sector (2048-268435455, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-268435455, default 268435455):
Using default value 268435455
Partition 1 of type Linux and of size 128 GiB is set

Command (m for help): p #打印分区表信息

Disk /dev/sdc: 137.4 GB, 137438953472 bytes, 268435456 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk label type: dos
Disk identifier: 0xd2c4a3c5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1            2048   268435455   134216704   83  Linux

Command (m for help): w #写入分区并保存
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[user01@host01 ~]$ sudo mkfs.ext4 /dev/sdc1 
# 格式化分区,这是因为每种操作系统所设定的文件属性/权限并不相同， 为了存放这些档案所需的数据，因此就需要将分割槽进行格式化，以成为操作系统能够利用的『文件系统格式(filesystem)』。 由此我们也能够知道，每种操作系统能够使用的文件系统不相同。 比如windows 98 以前的微软操作系统主要利用的文件系统是 FAT (或者 FAT16)，windows 2000 以后的版本有所谓的 NTFS 文件系统，至于 Linux 的正统文件系统则为 Ext2 (Linux second extended file system, ext2fs)。此外，在默认情冴下，windows 操作系统是不会认识 Linux 的Ext2 的。
mke2fs 1.42.9 (28-Dec-2013)
Discarding device blocks: done
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
8388608 inodes, 33554176 blocks
1677708 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=2181038080
1024 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

[user01@host01 ~]$ sudo mkdir /infa #创建目录
[user01@host01 ~]$ sudo mount /dev/sdc1 /infa #磁盘挂载到目录
[user01@host01 ~]$ df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs         63G     0   63G   0% /dev
tmpfs            63G     0   63G   0% /dev/shm
tmpfs            63G  642M   63G   1% /run
tmpfs            63G     0   63G   0% /sys/fs/cgroup
/dev/sda2        50G  4.2G   46G   9% /
/dev/sda9        10G   50M   10G   1% /home
/dev/sda5        15G  4.3G   11G  29% /var
/dev/sda11      8.0G   33M  8.0G   1% /housekeep
/dev/sda3        10G   37M   10G   1% /tmp
/dev/sda10      4.7G   33M  4.7G   1% /opt/IBM
/dev/sda1       497M  118M  380M  24% /boot
/dev/sda8       8.0G   33M  8.0G   1% /var/tmp
/dev/sda6        15G  215M   15G   2% /var/log
/dev/sda7       5.0G   68M  5.0G   2% /var/log/audit
/dev/sdb1       252G  2.1G  237G   1% /mnt/resource
tmpfs            13G     0   13G   0% /run/user/995
tmpfs            13G     0   13G   0% /run/user/1029
/dev/sdc1       126G   61M  120G   1% /infa
[user01@host01 infa]$ sudo chown -R user01:sysadmg00 /infa #目录赋权
[user01@host01 infa]$ sudo blkid #查看所有磁盘的UUID
/dev/sdb1: UUID="6634633e-001d-43ba-8fab-202f1df93339" TYPE="ext4"
/dev/sdc1: UUID="d4993a37-4a33-4c95-95de-9711413196c0" TYPE="ext4"
[user01@host01 ~]$ sudo vi /etc/fstab #编辑文件添加映射关系，重启自动挂载
#/dev/sdc1 /infa   ext4    defaults        0 0 # 不建议使用这种方式，重启后盘号可能会改变
UUID="d4993a37-4a33-4c95-95de-9711413196c0"    /infa   ext4    defaults        0 0
[user01@host01 ~]$ sudo reboot #可不用重启
```

## mount new disk more than 2T
```
[root@host01 ~]# umount /infa_shared 
[root@host01 ~]# parted /dev/sde #对磁盘进行分区操作
GNU Parted 3.1
Using /dev/sde
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mklabel # 建立磁盘标签                                                          
New disk label type? gpt                                                  
Warning: The existing disk label on /dev/sde will be destroyed and all data on this disk will be lost. Do you want to continue?
Yes/No? Yes                                                               
(parted) print                                                            
Model: Msft Virtual Disk (scsi)
Disk /dev/sde: 4398GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start  End  Size  File system  Name  Flags

(parted) mkpart primary 0 4398GB                                          
Warning: The resulting partition is not properly aligned for best performance.
Ignore/Cancel? Ignore                                                     
(parted) print
Model: Msft Virtual Disk (scsi)
Disk /dev/sde: 4398GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name     Flags
 1      17.4kB  4398GB  4398GB               primary

(parted) quit                                                             
Information: You may need to update /etc/fstab.
       
[root@host01 ~]# fdisk -l /dev/sde #查看分区情况
WARNING: fdisk GPT support is currently new, and therefore in an experimental phase. Use at your own discretion.

Disk /dev/sde: 4398.0 GB, 4398046511104 bytes, 8589934592 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk label type: gpt
Disk identifier: 56735FDA-B6C1-4454-98D6-DBE8CA63137D


#         Start          End    Size  Type            Name
 1           34   8589934558      4T  Microsoft basic primary
Partition 1 does not start on physical sector boundary. 
[root@host01 ~]# mkfs.ext4 /dev/sde1 #格式化分区
mke2fs 1.42.9 (28-Dec-2013)
/dev/sde1 alignment is offset by 3072 bytes.
This may result in very poor performance, (re)-partitioning suggested.
Discarding device blocks: done                            
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
268435456 inodes, 1073741815 blocks
53687090 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=3221225472
32768 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968, 
        102400000, 214990848, 512000000, 550731776, 644972544

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done       

[root@host01 ~]# mount /dev/sde1 /infa_shared #挂载分区
[root@host01 ~]# ls -l /dev/disk/by-uuid/ #查看UUID
total 0
lrwxrwxrwx. 1 root root 10 Feb 26 09:53 073eaa17-5ac5-4017-855f-5b067864004d -> ../../sdc1
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 233e5dcb-51f0-48b1-a941-e948ed6ec8ec -> ../../dm-4
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 58e5db49-8935-4325-80c1-6628c0d61820 -> ../../sda1
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 60159605-e89a-458f-b474-d587e86ce4ad -> ../../sdb1
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 6f701637-4bfc-4067-a1b8-ff322b287bd2 -> ../../dm-1
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 83266738-232f-4daa-b442-a3e0bdbc1979 -> ../../dm-3
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 8d4f8350-fec9-465b-9c15-945032f09d8e -> ../../dm-0
lrwxrwxrwx. 1 root root 10 Feb 22 13:39 b8f675fe-6736-484e-b34a-edba5f85080a -> ../../dm-2
lrwxrwxrwx. 1 root root 11 Feb 22 13:39 F3D4-BA52 -> ../../sda15
[root@host01 ~]#  vi /etc/fstab #设置开机自动挂载磁盘

UUID=****** /infa_shared  ext4   defaults  0 0

```

[参考链接](https://www.jianshu.com/p/4675897b41b4?hmsr=toutiao.io)
