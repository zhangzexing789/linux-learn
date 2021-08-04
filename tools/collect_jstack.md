
```shell
#!/bin/bash
PID=$1
ITERATION=0
mkdir -p "/tmp/hive-"`date +"%d-%m-%Y"`""
while [ $ITERATION -le 5 ]
do
        jstack -l $PID > "/tmp/hive-"`date +"%d-%m-%Y"`"/hive_jstack-"`date +"%d-%m-%Y-%H%M%S"`""
        jmap -heap $PID > "/tmp/hive-"`date +"%d-%m-%Y"`"/hive_jmap-"`date +"%d-%m-%Y-%H%M%S"`""
        ((ITERATION++))
        sleep 5
done
jmap -histo:live $PID > "/tmp/hive-"`date +"%d-%m-%Y"`"/hive_jmap-"`date +"%d-%m-%Y-%H%M%S"`""
```