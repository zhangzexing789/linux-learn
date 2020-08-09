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

ln -s 源目录路径 目标目录路径
ln -s /infa/infa_shared/software ./software

https://blog.csdn.net/chenghuikai/article/details/50961622
