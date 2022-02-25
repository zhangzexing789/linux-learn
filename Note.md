[TOC]

# Note

## 变量
 - 定义变量时等号两边都不能接空格
 `test =shell`将报错
 - 可以使用单引号`''`或者双引号`""`定义带空格的变量
    - 双引号内的特殊字符如 $ 等，可以保有原本的特性 ，如
` var="lang is $LANG" `则` echo $var `可得` lang is zh_TW.UTF 8 `
    - 单引号内的特殊字符则仅为一般字符 纯文本 ))，如
`var='lang is $LANG'`  则`echo $var`  可得`lang is $LANG`
 - 使用转义字符`\`转移特殊符号，如[enter],$,\,空格,'',""等
```
hostname:username:/user/aappa01> test=shell\ hello
hostname:username:/user/aappa01> echo $test
shell hello
```
 - 增加变量内容
 `test=$test!` 则 `echo $test`可得`shell hello!`
 - 若该变量需要在其他子程序执行，则 需要以 export 来使变量变成环境变量
 - 取消变量的方法为使用 unset ：`unset 变量名称`例如取消

## 变量的分类
 - 内部变量：系统提供，不用定义，不能修改
 ```
 $n     $1 表示第一个参数，$2 表示第二个参数 ...
 $#     命令行参数的个数
 $0     当前程序的名称
 $?     前一个命令或函数的返回码
 $*     以"参数1 参数2 ... " 形式保存所有参数
 $@     以"参数1" "参数2" ... 形式保存所有参数
 $$     本程序的(进程ID号)PID
 ```
 - 环境变量：系统提供，不用定义，可以修改,可以利用export将用户变量转为环境变量.
 有以下两部分：
    - 系统设置：HOME,LOGNAME,MAIL,PATH,PS1,PWD,SHELL,TERM等
    - 用户设置，由export命令导出的
 - 用户变量（私有变量,本地变量）：用户定义，可以修改

## 变量命令
 - set：显示当前 Shell 所有变量，包括其内建环境变量（与 Shell 外观等相关），用户自定义变量及导出的环境变量，即包含了 env 和 export 命令的变量。
 - env：显示当前用户的环境变量
 - export：显示(设置)当前导出成环境变量的shell变量(注意：export为bash或类bash私有的命令)
 - unset 删除变量
 - readonly 将变量变为只读，所以无法删除

 ```
 [root@linux ~]# aaa=bbb            #声明变量并赋值
 [root@linux ~]# echo $aaa          #显示变量值
 bbb
 [root@linux ~]# set|grep aaa       #查找并显示指定shell变量
 aaa=bbb
 [root@linux ~]# env|grep aaa       #这里找不到，因为还未声明为环境变量
 [root@linux ~]# export aaa         #声明为环境变量
 [root@linux ~]# env|grep aaa       #找到了
 aaa=bbb
 [root@linux ~]# readonly aaa       #将变量aaa变成只读
 [root@linux ~]# unset aaa
-bash: unset: aaa: cannot unset: readonly variable  #删除报错

 ```

## 命令的执行顺序
 a. 以相对 绝对路径执行指令，例如『 /bin/ls 』或『 ./ls 』；
 b. 由 alias 找到该指令来执行；
 c. 由 bash 内建的 (builtin) 指令来执行；
 d. 透过 $PATH 这个变量的顺序搜寻到的第一个指令来执行。

 ```
[dmtsai@study ~]$ alias echo='echo -n'
[dmtsai@study ~]$ type -a echo
echo is aliased to `echo -n'
echo is a shell builtin
echo is /usr/bin/echo
 ```
 以上的echo命令就是按照alias，builtin，$PATH的顺序去查找echo指令

## 编辑 .profile 文件出生成 .profile.swp 文件

 由于vi /etc/profile还没有编辑完成，保存退出，突然断电 或其他原因导致编辑窗口关闭了，系统为保护文件，产生一个备份文件/etc/.profile.swp，保存着上次未保存时的文件状态，在下次使用vi打开/etc/profile就会读取到/etc/.profile.swp出现这种警告。

 也就出现了以下选项：
 - [O]pen Read-Only, 只读
 - [E]pdit anyway    强制进入编辑
 - [R]ecover,    恢复到上次未保存状态
 - [D]elete it,  直接删除/etc/.profile.swp，
 - [Q]uit, 退出
 - [A]bort:  中断

 选择操作后要删除.profile.swp 文件。

 ## 查看linux 版本
 - 内核版本
 `uname -a`或者`cat /proc/version`
 - 系统版本
 `lsb_release -a `
 适用于所有的Linux发行版，包括Redhat、SuSE、Debian…等发行版

 `cat /etc/redhat-release`
只适合Redhat系的Linux

`cat /etc/issue`
适用于所有的Linux发行版

 ## 开启防火墙

使用命令行工具`firewall-cmd`进行管理
 - 默认已安装或者root用户使用`yum install -y firewalld`进行安装
 - 启用在开机启动防火墙
 ```
systemctl enable firewalld
 ```
 - 重启
 ```
systemctl restart firewalld
 ```
 - 检查防火墙状态
 ```
systemctl status firewalld.service
 ```
 - 启动
 ```
systemctl start firewalld.service
 ```
 - 停止
 ```
 systemctl stop firewalld.service
 ```
 - 列出允许的服务
 ```
firewall-cmd --list-services
 ```
 - 列出允许的端口
 ```
 firewall-cmd --list-ports
 ```
 - 启用服务的所有传入端口
```
firewall-cmd --permanent --zone=public --add-service=http
```
remember to restart firewall service
 - 开启指定端口                                                                      
```
firewall-cmd --permanent --zone=public --add-port=2222/tcp
```

## /etc/hosts , /etc/hostname 和 /etc/sysconfig/network

- /etc/hostname和/etc/sysconfig/network用于修改主机名，hostname直接用newhostname替换，network则修改HOSTNAME=NEWNAME，需要重启系统。
- /etc/hosts 是域名解析文件

[出现配置hosts文件也能修改hostname](https://www.jb51.net/LINUXjishu/77534.html)

## `su` 与 `sudo` (swich user) 切换用户
- `su - `

是`su -l`的缩写，后面接将切换的用户名，不写则默认使用root用户,通过命令`exit`或`logout`，或者是快捷键Crtl+D即可返回原用户身份。`su`也需要该用户加入组`wheel`才有效，否则切换时将不成功并且报错`su: Permission denied`。

- `su -`和`su`

su - USERNAME切换用户后，同时切换到新用户的工作环境中
su USERNAME切换用户后，不改变原用户的工作目录，及其他环境变量目录

- `sudo`

是无须登录root，也不需要root密码即可执行root命令，root用户通过使用visudo命令编辑sudo的配置文件/etc/sudoers，才可以授权其他普通用户执行sudo命令。

 [参考链接](https://www.cnblogs.com/xd502djj/p/6641475.html)

## 使用vim 查看和文件编码转换
  - 查看：`:set fileencoding`
  - 转换为utf-8：`:set fileencoding=utf-8`

## 查看用户的所属组
```
groups 查看当前登录用户的组内成员
groups gliethttp 查看gliethttp用户所在的组,以及组内成员
whoami 查看当前登录用户名
```
## lost+found 文件夹

lost+found 是一个特殊目录，用途是用来存放文件系统错误导致文件丢失后找回数据的，用来存放fsck过程中部分修复的文件的。
这个目录在分区的根目录上（注意是分区的，而不是整个系统的）。
所以你就可以理解了，分区挂载后的目录里面会有这么个东西。
不过这不是绝对的。
ext2/3/4 就有这个目录，但是有些文件系统没有这个目录，比如 reiserfs 就没有，tmpfs 也没有。
其他文件系统也是有的有有的没有。

[相关链接](https://www.jianshu.com/p/417ba2d7a4b3)

## 处理 umount target is busy 挂载盘卸载不掉问题

Linux下挂载后的分区或者磁盘某些时候需要umount的时候出现类似“umount: /mnt: target is busy.”等字样，或者“umount: /xxx: device is busy.”。

该报错通常是由于待卸载磁盘正在使用，导致无法直接卸载。需要将当前使用数据盘的进程杀掉，才能卸载。

1.  使用fuser命令处理
- 安装fuser命令

```
[root@server-10 ~]# yum install psmisc 
```
- 查看在使用的进程
```
[root@server-10 ~]# fuser -mv /mnt/
                     USER        PID ACCESS COMMAND
/mnt:                root     kernel mount /mnt
                     root      13830 ..c.. bash
```
- 杀死占用的进程，并再次查看

```
[root@server-10 ~]# fuser -kv /mnt/
                     USER        PID ACCESS COMMAND
/mnt:                root     kernel mount /mnt
                     root      13830 ..c.. bash
[root@server-10 ~]# fuser -mv /mnt/
                     USER        PID ACCESS COMMAND
/mnt:                root     kernel mount /mnt
```
- 确认无进程连接后，使用卸载命令

```
[root@server-10 ~]# umount /mnt/
[root@server-10 ~]# 
```
- 参数说明：

    - -k,--kill kill 　　processes accessing the named file
    - -m,--mount 　　 show all processes using the named filesystems or block device
    - -v,--verbose 　　 verbose output

- 注意：

可以使用 fuser -km /mnt 进行 kill 进程。
可以使用 kill 命令杀掉查到对应的进程 。
强制 kill 进程可能会导致数据丢失，请确保数据得到有效备份后，再进行相关操作。

2. 通过lsof命令处理

```
[root@server-10 ~]# lsof /mnt/
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
bash    16302 root  cwd    DIR   8,17       50   64 /mnt
```
找到PID对应的进程或者服务，然后杀死或者停止相应服务即可。

3. 参考链接

[解决类似umount target is busy挂载盘卸载不掉问题](https://www.cnblogs.com/ding2016/p/9605526.html)

## shell 脚本中调用环境变量不生效的问题

1. 在用户的profile文件定义环境时没有使用export，此时声明的变量并不是真正的环境变量，不能在后面的shell脚本被调用。 


## 修改时区

使用root用户，无需重启
```
timedatectl list-timezones |grep -i Hong

timedatectl set-timezone "Asia/Hong_Kong"

timedatectl

```

## yum install 发现/var空间不足

- du -h --max-depth=1 查看占用大的文件
- 复制文件夹到其他地方
- 删除原来文件
- 软链接复制的路径到原路径

https://blog.csdn.net/cloudeagle_bupt/article/details/74887435


## 误操作将全局变量 PATH 重置
在其他服务器复制变量值，使用export 重新指定

## 查看 资源占用最多的进程

- 查看占用内存最多的十个进程

`ps aux|head -1;ps aux|grep -v PID|sort -rn -k +4|head`

- 查看占用cpu最多的十个进程

`ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head`

## 查看系统重启时间

https://www.cnblogs.com/kerrycode/p/3759395.html

## mount new disk

```
[godesladm1@GOAZEDLAP0067 ~]$ sudo fdisk /dev/sdc
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xd2c4a3c5.

The device presents a logical sector size that is smaller than
the physical sector size. Aligning to a physical sector (or optimal
I/O) size boundary is recommended, or performance may be impacted.

Command (m for help): m
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
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)

Command (m for help): n
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

Command (m for help): p

Disk /dev/sdc: 137.4 GB, 137438953472 bytes, 268435456 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk label type: dos
Disk identifier: 0xd2c4a3c5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1            2048   268435455   134216704   83  Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[godesladm1@GOAZEDLAP0067 ~]$ sudo mkfs.ext4 /dev/sdc1
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

[godesladm1@GOAZEDLAP0067 ~]$ sudo mkdir /infa
[godesladm1@GOAZEDLAP0067 ~]$ sudo mount /dev/sdc1 /infa
[godesladm1@GOAZEDLAP0067 ~]$ df -h
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
[godesladm1@GOAZEDLAP0067 infa]$ sudo chown -R godesladm1:sysadmg00 /infa
[godesladm1@GOAZEDLAP0067 ~]$ sudo vi /etc/fstab
/dev/sdc1       /infa   ext4    defaults        0 0
[godesladm1@GOAZEDLAP0067 ~]$ sudo reboot
```
## 将awk结果赋予变量
```
CLUSTER_STATUS=`sh /infa/infa_shared/HalleyCommon/HDInsight/getClustersInf.sh|awk '/clusterState/ {print $0}'`
```
执行语句加上``，不然会直接print到界面。

## 查看系统安全相关日志
/var/log/secure, /var/log/messages

## 执行shell脚本的三种方式
- 切换到shell脚本所在的目录（此时，称为工作目录）执行shell脚本。
```
cd /data/shell
./hello.sh
```
- 以绝对路径的方式去执行bash shell脚本, 脚本必须有执行`x`的权限。
```
/data/shell/hello.sh
```
- 直接使用bash 或sh 来执行bash shell脚本。这是将hello.sh作为参数传给sh(bash)命令来执行的，不是hello.sh自己来执行，而是被人家调用执行，所以不要执行权限,也不需要声明解释器，即不用指定bash路径。
```
cd /data/shell
bash hello.sh
cd /data/shell
sh hello.sh
# 或者
bash /data/shell/hello.sh
sh /data/shell/hello.sh
```
- 在当前的bash环境中执行bash shell脚本。前三种方法执行shell脚本时都是在当前bash（称为父bash）开启一个子bash环境，此shell脚本就在这个子bash环境中执行。shell脚本执行完后子bash环境随即关闭，然后又回到父bash中。而方法四则是在当前bash 进程中执行的，可以用`echo $$` 输出当前bash的进程id进行验证。
```
cd /data/shell
. hello.sh
# 或者
cd /data/shell
source hello.sh
```
## 命令 /bin/sh -c "<command>"

1. 作用：接收一连串的命令，并执行。
如：`/bin/sh -c "echo hello"` 和 `echo hello` 是一样的效果。
2. 区别：双引号里面的命令将会被当作一个整体执行。
比如一个只有root用户才有权限写的文件`test.txt`, 使用`sudo echo hello > test.txt` 仍然会报`Permission denied`权限不足的错误，这是因为重定向符号 “>” 和 ">>" 也是 bash 的命令。我们使用 sudo 只是让 `echo` 命令具有了 root 权限，但是没有让 `>` 和 `>>` 命令也具有 root 权限，所以 bash 会认为这两个命令都没有文件写入信息的权限。此时可以用`sudo /bin/sh -c "echo hello > test.txt"`解决。
另一种方法是利用管道和 tee 命令，该命令可以从标准输入中读入信息并将其写入标准输出或文件中，具体用法如下：
`echo "hello" | sudo tee -a test.txt`
注意，tee 命令的 "-a" 选项的作用等同于 `>>` 命令，如果去除该选项，那么 tee 命令的作用就等同于 `>` 命令。

## shell 参数说明

- `$0`: 执行的文件名（包含文件路径）
- `$n`: n 代表一个数字，1 为执行脚本的第一个参数，2 为执行脚本的第二个参数，以此类推.
- `$#`:	传递到脚本的参数个数
- `$*`:	以一个单字符串显示所有向脚本传递的参数。
如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
- `$$`:	脚本运行的当前进程ID号
- `$!`:	后台运行的最后一个进程的ID号
- `$@`:	与`$*`相同，但是使用时加引号，并在引号中返回每个参数。
如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
- `$-`:	显示Shell使用的当前选项，与set命令功能相同。
- `$?`:	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。

