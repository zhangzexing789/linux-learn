# ln

## 硬链接
ln [source file] [tatget file]

```shell

[testuser]$ ll
total 4
-rw-r--r--. 1 infadev etlsl 6 Aug  4 03:42 test
[testuser]$ ln test ./t1
[testuser]$ ll
total 8
-rw-r--r--. 2 infadev etlsl 6 Aug  4 03:42 t1
-rw-r--r--. 2 infadev etlsl 6 Aug  4 03:42 test
[testuser]$ ls -il
total 8
5506157 -rw-r--r--. 2 infadev etlsl 6 Aug  4 03:42 t1
5506157 -rw-r--r--. 2 infadev etlsl 6 Aug  4 03:42 test
```

- 可以看到上面的文件链接数由1变为2

- 两个文件的索引是一样的

## 软链接
- 创建

```
ln -s 源目录路径 目标目录路径
ln -s /infa/infa_shared/software ./software
```
https://blog.csdn.net/chenghuikai/article/details/50961622



## 硬链接

- 不需使用绝对路径
- 目录不能创建硬链接
- 同一个源文件的所有硬链接文件必须在同一个硬盘，同一个分区里边

```
ln -d 目标文件 源文件
ln -d ./test_target.txt /infa/infa_shared/test_source.txt
```

## 删除链接

```
rm -rf ./software # 仅删除链接文件，不影响源文件
rm -rf ./software/ # 连源文件一并删除
```

https://www.linuxprobe.com/delete-directory-link.html

## 批量替换当前目录下所有文件的内容

```
find /data/app_resource -type f |xargs sed -i 's/192.168.220.126/192.168.221.160/g'
```


