#!/usr/bin/env bash

# 功能：打印指定java进程的堆栈信息，并输出到文件。
# 参数：<进程号>
# 例子：
#   sh collect_jstack_jmap.sh 1299
#   */1 * * * * sh collect_jstack_jmap.sh 1299 #加入crontab定时1分钟收集一次

PID=$1
ITERATION=0
mkdir -p "/tmp/hive-"`date +"%d-%m-%Y"`""
while [ $ITERATION -le 5 ]
do
        jstack -l $PID > "/tmp/hive-"`date +"%d-%m-%Y"`"/hive_jstack-"`date +"%d-%m-%Y-%H%M%S"`""
        #查看进程堆内存使用情况:包括使用的GC算法、堆配置参数和各代中堆内存使用
        jmap -heap $PID > "/tmp/hive-"`date +"%d-%m-%Y"`"/hive_jmap-"`date +"%d-%m-%Y-%H%M%S"`""
        ((ITERATION++))
        sleep 5
done
#查看堆内存中的对象数目、大小统计直方图，如果带上live则只统计活对象
jmap -histo:live $PID > "/tmp/hive-"`date +"%d-%m-%Y"`"/hive_jmap-"`date +"%d-%m-%Y-%H%M%S"`"" 
