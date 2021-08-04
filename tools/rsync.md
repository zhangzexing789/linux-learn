- 用于同步分发多个服务器之间的文件或者目录，前提这些服务器已经实现相互免密登录
- 参数：<目标文件或者目录> 输入需要同步的文件或者目录

> rsync.sh
```shell
#!/bin/bash
#1. 判断参数个数
if [ $# -lt 1 ];then
    echo "Usage: rsync.sh <目标文件或者目录>"
    exit 1
fi
#2. 遍历集群所有机器,这里指定要同步的服务器名
for host in GOAZESLAP0038; do
    echo ==================== $host ====================
    #3. 遍历所有目录，挨个发送
    for file in $@; do
        #4. 判断文件是否存在
        if [ -e $file ];then
            #5. 获取父目录
            pdir=$(cd -P $(dirname $file);pwd)
            #6. 获取当前文件的名称
            fname=$(basename $file)
            ssh $host "mkdir -p $pdir"
            rsync -av $pdir/$fname $host:$pdir
        else
            echo $file does not exists!
        fi
    done
done

```