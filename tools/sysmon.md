- 这个脚本将收集命令的输出：top output, vmstat output, ps output and disk space output
- 参数：
    - <frequency-in-seconds> 收集的间隔时间（秒）
    - [<number-of-iterations>] 收集的次数，不指定的话将一直收集直至停止

> sysmon.sh
```shell
#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Usage: sysmon.sh <frequency-in-seconds> [<number-of-iterations>]"
    exit 1
fi

#sleep interval in seconds
SLEEP=$1
ITERATIONS=0
if [ $# -ge 2 ]
then
    ITERATIONS=$2
fi

OUTPUT_PREFIX=sysmon_`hostname`
CMD_CURRENT_HOUR="date +%Y-%m-%d_%H%M"
OLD_OUTPUT_DIR=       
OUTPUT_DIR=

set_output_location() {
    OUTPUT_DIR="${OUTPUT_PREFIX}_`${CMD_CURRENT_HOUR}`"
    SCRIPTLOG="${OUTPUT_DIR}/sysmon.log"
    if [ "${OLD_OUTPUT_DIR}" != "${OUTPUT_DIR}" ]
    then
	mkdir -p ${OUTPUT_DIR}		
        exec 1<&-
        exec 2<&-
        exec >>${SCRIPTLOG}
        exec 2>&1
        OLD_OUTPUT_DIR="${OUTPUT_DIR}"
    fi
}

log() {
    echo "`date +%Y-%m-%d\ %H:%M:%S`:    $1" 
}

archive_if_necessary() {
    if [ "$OUTPUT_DIR" != "$OLD_OUTPUT_DIR" ]
    then
       ARCHIVE="${OLD_OUTPUT_DIR}.tar.gz"
       log "New directory! Archiving old logs to $ARCHIVE"
       tar -cvzf $ARCHIVE $OLD_OUTPUT_DIR/*
       # log "Removing old dir $OLD_OUTPUT_DIR"
       # rm -rf ${OLD_OUTPUT_DIR}
       # log "Removed $OLD_OUTPUT_DIR"
    fi
}

log_and_exec() {
    log "START $1" 
    PREFIX=${TIME}
    OUTPUT_FILE=${OUTPUT_DIR}/$1.out
    #eval $2 | sed "s/^/$PREFIX | /g" >> "${OUTPUT_DIR}/${OUTPUT_FILE}.out"
	echo "################## $PREFIX ##################" >> ${OUTPUT_FILE}
	eval $2 >> ${OUTPUT_FILE}
    log "DONE $1"
}


if [ $# -lt 1 ]
then
    echo "Usage: sysmon.sh <sleep-in-seconds>"
    exit 1
fi


#sleep interval in seconds
SLEEP=$1

set_output_location
log "Script started with sleep interval of $SLEEP seconds"
log "Host=`hostname`"
log "Uname=`uname -a`"
if [ $ITERATIONS -eq 0 ]
then
    log "Sysmon will run forever until termination"
else
    log "Sysmon will stop after ${ITERATIONS} iterations"
fi

CNT=1
trap "{ echo Sysmon interrupted by signal. Halting!; exit 255; }" SIGINT SIGQUIT SIGTERM SIGKILL
trap "{ echo HUP received }" SIGHUP
while [ $ITERATIONS -eq 0 ] || [ $CNT -le $ITERATIONS ]
do
    #set_output_location 
    #archive_if_necessary

    TIME=`date +%Y-%m-%d\ %H:%M:%S`
    #export PREFIX=${TIME}
    log "Woke up!"
	log_and_exec "ps" "ps -ef"
    log_and_exec "top" "top -b -n 1" 
    log_and_exec "vmstat" "vmstat 1 2 | tail -1"
    log_and_exec "Disk" "df -hT"
   #log_and_exec "netstat" "netstat -as" 
   #log_and_exec "netstat" "netstat -peano" 
   #log_and_exec "loadavg" "cat /proc/loadavg" 
   #log_and_exec "runnables" "ps -eLo state,pid,tid,cpu,comm,time,args | egrep '^(R|D)'" 
   #log_and_exec "iostat" "iostat -x 1 2"
   #log_and_exec "lsof" "lsof"
    log "Zzzzz"
    if [ $ITERATIONS -ne 0 ]
    then
        CNT=`expr $CNT + 1`
    fi
    sleep $SLEEP 
done

log "Sysmon completed $ITERATIONS iterations. Halting!"
```