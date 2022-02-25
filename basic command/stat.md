# stat
## 作用
用于显示 目录或者文件的详细信息。

```shell
$ stat /joson/test.txt
  File: /joson/test.txt # 文件的绝对路径名.
  Size: 16  # 文件大小（以字节为单位）     
  Blocks: 1  # 此文件使用的块总数。         
  IO Block: 65536 # 此文件的 IO 块大小。
  regular file # 指示文件类型。这表明这是一个常规文件。以下是可用的文件类型：regular file：all normal files；directory：directories；socket:sockets；symbolic link: symbolic links；block special file: hard disk;character special file: terminal device file.
  Device: fac6d503h/4207334659d #  以十六进制和十进制显示的设备编号
  Inode: 22236523160400909  # Inode 编号，是每个文件的唯一编号，用于文件系统的内部维护。
  Links: 1 # 文件的链接数
  Access: (0755/-rwxr-xr-x)  # 以八进制和字符格式显示的访问说明符。
  Uid: (1446641/hadoop)   # 显示文件所有者的用户 id 和用户名。
  Gid: (1049089/hadoop) # 显示文件所有者的组 id 和组名。
  Access: 2019-05-28 09:10:38.417681600 +0800 # 文件最后访问的信息。
  Modify: 2019-05-28 10:43:28.206121200 +0800 # 文件内容修改时间。
  Change: 2019-05-28 10:44:06.203121200 +0800 # 文件内容或者权限修改时间，即文件的inode 数据最后改动时间。
  Birth: 2019-05-28 09:10:38.417681600 +0800 # 文件生成时间
```