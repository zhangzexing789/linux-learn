# 处理 umount target is busy 挂载盘卸载不掉问题

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
