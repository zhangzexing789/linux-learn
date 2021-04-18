# find

## 功能

用于查找文件目录

## 用法

find　（参数）（选项）即 find  [指定查找目录]  [查找规则]  [查找完后执行的action]
> 默认查找当前目录及其子目录的所有文件，而位于参数之前的字符串都会被认定为查找的目录名。

## 参数

查找的目录，可以同时指定几个目录

## 选项

- 根据名字查找

```shell
-name: 按照给定的字符串查找
-maxdepth 1： 限制当前目录
-iname: 不区分大小写查找
通配符说明：*　用于匹配任意字符；？　用于匹配任意单个字符；[] 用于匹配括号内的任意一个字符
```

- 根据所属用户或者群组

```shell
-user
-group
-uid: 查找指定uid
-gid: 查找指定gid
```

- 根据多个条件

```shell
-a    条件与
-o    条件或
-not    条件取反
```

- 根据文件的时间戳（用stat [文件] 查看文件信息）

```shell
-atime(天)，-amin（分钟）  文件最后一次被访问时间。 如：-atime 7 恰好在七天前访问的文件
-mtime（天），-mmin（分钟）  文件最后一次被修改时间。 如： -mtime -7  在七天内被修改的文件
-ctime（天），-cmin（分钟）  文件数据元（例如权限等）最后一次修改时间。 如：-ctime +7  超过七天被修改权限的文件
```

- 根据文件类型

```shell
-type
f     // 普通文件
d     //目录文件
l     //链接文件
b     //块设备文件
c     //字符设备文件
p     //管道文件
s     //socket文件
```

- 根据文件的大小

```shell
-size
b —— 块（512字节）
c —— 字节
w —— 字（2字节）
k —— 千字节
M —— 兆字节
G —— 吉字节
同样的‘-’和‘+’表示范围，如 find -type f -size +10k 搜索文件大小大于10k的
```

- 根据文件权限

```shell
-perm [num]
 ```

## 查找后的action

```shell
-print                                 //默认情况下的动作
-delete                                //搜索匹配文件并删除
-ls                                     //查找到后用ls 显示出来
-ok  [commend]                //查找后执行命令的时候询问用户是否要执行
-exec [commend]              //查找后执行命令的时候不询问用户，直接执行.当 find 结果为true时， 执行后面的命令 ，{} 表示搜索得到的结果
find .-type f -user root -exec chown tom {} \;    将root所属的文件变更其所有权为用户 tom
find . -name '*.txt' -ok rm {} \;     删除当前目录及其子目录下的txt文件
```

## 实例

- 查找多个目录

```shell
asnphtl@CIGWKL7251BVV /$ find /joson/ /home/ASNPHTL/ -name 'test*'
/joson/test.txt
/joson/test1
/home/ASNPHTL/test
```

- 查找当前目录
```shell
find . -maxdepth 1 -name '*.sh'
```

- stat 命令

```shell
asnphtl@CIGWKL7251BVV /joson$ stat /joson/test.txt
  File: /joson/test.txt
  Size: 16              Blocks: 1          IO Block: 65536  regular file
Device: fac6d503h/4207334659d   Inode: 22236523160400909  Links: 1
Access: (0755/-rwxr-xr-x)  Uid: (1446641/ asnphtl)   Gid: (1049089/Domain Users)
Access: 2019-05-28 09:10:38.417681600 +0800
Modify: 2019-05-28 10:43:28.206121200 +0800   #文件内容修改时间
Change: 2019-05-28 10:44:06.203121200 +0800   #文件内容或者权限修改时间
 Birth: 2019-05-28 09:10:38.417681600 +0800
```
