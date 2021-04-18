# crontab

## 选项

```shell
-e: 编辑当前用户的定时任务
-l: 列出当前用户的定时任务
-r: 清空当前用户的定时任务
```

## 系统任务和用户任务

### 系统任务

> 系统周期性所要执行的工作，比如写缓存数据到硬盘、日志清理等。`/etc/crontab` 就是系统任务调度的配置文件。

### 用户任务

> 用户自定义的任务，目录`/var/spool/cron`下对应用户名的文件就是配置文件。

## crontab 格式

`minute   hour   day   month   week   command     顺序：分 时 日 月 周`

```txt

minute： 表示分钟，0~59
hour：表示小时，0~23
day：表示日期，1~31
month：表示月份，1~12
week：表示星期几，0~7,0或7代表星期日。

星号（*）：代表所有可能的值，例如month字段如果是星号，则表示在满足其它字段的制约条件后每月都执行该命令操作。
逗号（,）：可以用逗号隔开的值指定一个列表范围，例如，“1,2,5,7,8,9”
中杠（-）：可以用整数之间的中杠表示一个整数范围，例如“2-6”表示“2,3,4,5,6”
正斜线（/）：可以用正斜线指定时间的间隔频率，例如“0-23/2”表示每两小时执行一次。同时正斜线可以和星号一起使用，例如*/10，如果用在minute字段，表示每十分钟执行一次。

```

### 注意事项

1. 使用date 变量

 `` `date +"\%Y\%m\%d"`_formal.log ``

- `` ` `` 这不是单引号
- date 后面要有空格
- % 前面需要加转义符号 ` \ `
  
2. 自定义脚本中使用的环境变量将不生效，应该使用绝对路径或者 source 命令

## crond 服务

```shell

/sbin/service crond start    //启动服务
/sbin/service crond stop     //关闭服务
/sbin/service crond restart  //重启服务
/sbin/service crond reload   //重新载入配置
chkconfig –level 35 crond on //加入开机自启
```

- `You (username) are not allowed to use this program (crontab)`
该问题需 root 将当前用户加入crontab 允许列表，即 `echo username >> /etc/cron.allow`

- 所有任务执行日志文件 `/var/log/cron`

## 实例

```shell
每1分钟执行一次command
* * * * * command

每小时的第3和第15分钟执行
3,15 * * * * command

在上午8点到11点的第3和第15分钟执行
3,15 8-11 * * * command

每隔两天的上午8点到11点的第3和第15分钟执行
3,15 8-11 */2 * * command

每个星期一的上午8点到11点的第3和第15分钟执行
3,15 8-11 * * 1 command

每晚的21:30重启smb
30 21 * * * /etc/init.d/smb restart

每月1、10、22日的4 : 45重启smb
45 4 1,10,22 * * /etc/init.d/smb restart

每周六、周日的1:10重启smb
10 1 * * 6,0 /etc/init.d/smb restart

每天18 : 00至23 : 00之间每隔30分钟重启smb
0,30 18-23 * * * /etc/init.d/smb restart

每星期六的晚上11:00 pm重启smb
0 23 * * 6 /etc/init.d/smb restart

每一小时重启smb
* */1 * * * /etc/init.d/smb restart

晚上11点到早上7点之间，每隔一小时重启smb
* 23-7/1 * * * /etc/init.d/smb restart

每月的4号与每周一到周三的11点重启smb
0 11 4 * mon-wed /etc/init.d/smb restart

一月一号的4点重启smb
0 4 1 jan * /etc/init.d/smb restart

每小时执行/etc/cron.hourly目录内的脚本
01 * * * * root run-parts /etc/cron.hourly



```
