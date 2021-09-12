#!/usr/bin/env bash

# 功能：打印指定进程CPU占用高的线程堆栈信息。
# 参数：<进程号> [打印行数(默认是10行)]
# 例子：
#   sh get_jstack_info_for_high_cpu.sh 1299 30

if [ $# -le 0 ]; then
    echo "usage: $0 <pid> [line-number]"
    exit 1
fi

# java home
if test -z $JAVA_HOME 
then
    JAVA_HOME='/usr/local/jdk'
fi

#pid
pid=$1
# checking pid
if test -z "$($JAVA_HOME/bin/jps -l | cut -d '' -f 1 | grep $pid)"
then
    echo "process of $pid is not exists"
    exit
fi

#line number
linenum=$2
if test -z $linenum
then
    linenum=10
fi

stackfile=stack$pid.dump
threadsfile=threads$pid.dump

# generate java stack
$JAVA_HOME/bin/jstack -l $pid >> $stackfile
ps -mp $pid -o THREAD,tid,time | sort -k2r | awk '{if ($1 !="USER" && $2 != "0.0" && $8 !="-") print $8;}' | xargs printf "%x\n" >> $threadsfile
tids="$(cat $threadsfile)"
for tid in $tids
do
    echo "------------------------------ ThreadId ($tid) ------------------------------"
    cat $stackfile | grep 0x$tid -A $linenum
done

rm -f $stackfile $threadsfile

