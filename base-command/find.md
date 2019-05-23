## find 命令

```
 . 列出当前目录及其子目录下所有文件和文件夹
 -path '*/joson/*' -name '*.txt'  列出目录“joson” 下所有 TXT 文件
 -path '*/joson/*' ！ -name '*.txt'  列出目录“joson” 下所有的不是 TXT 文件
 -iname 文件名忽略大小写
 -ls 显示详细信息
 -atime(天)，-amin（分钟）  文件最后一次被访问时间。 如：-atime 7 恰好在七天前访问的文件
 -mtime（天），-mmin（分钟）  文件最后一次被修改时间。 如： -mtime -7  在七天内被修改的文件
 -ctime（天），-cmin（分钟）  文件数据元（例如权限等）最后一次修改时间。 如：-ctime +7  超过七天被修改权限的文件
 -type 按文件类型搜索（f： 普通文件， l： 符号连接， d： 目录， c： 字符设备， b： 块设备， s： 套接字， p： Fifo）
 -size 按文件代销搜索（b —— 块（512字节） c —— 字节 w —— 字（2字节）k —— 千字节 M —— 兆字节 G —— 吉字节），同样的‘-’和‘+’表示范围，如 find -type f -size +10k 搜索文件大小大于10k的
 -delete 搜索匹配文件并删除
 -perm  匹配权限的文件，如 find -type f -perm 777 匹配权限是777的文件
 -user  匹配用户拥有的文件，如find -type f - user admin 匹配用户admin拥有的文件
 -group 匹配用户组拥有的文件

```
### find 命令的高级应用
-exec 当 find 结果为true时， 执行后面的命令 ，{} 表示搜索得到的结果
```
find .-type f -user root -exec chown tom {} \;    将root所属的文件变更其所有权为用户 tom
```
-ok 与 -exec 唯一的区别就是会进行提示，等进一步的确认
```
find . -name '*.txt' -ok rm {} \;     删除当前目录及其子目录下的txt文件

find . -type f -mtime +30 -name "*.log" -exec cp {} old \;     将30天前的.log文件移动到old 目录下
```
