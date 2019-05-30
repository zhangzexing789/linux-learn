1. 功能
用于查看系统的网络信息

2. 用法
netstat (选项)

3. 选项
```
-a或--all：显示所有连线中的Socket；
-A<网络类型>或--<网络类型>：列出该网络类型连线中的相关地址；
-c或--continuous：持续列出网络状态；
-C或--cache：显示路由器配置的快取信息；
-e或--extend：显示网络其他相关信息；
-F或--fib：显示FIB；
-g或--groups：显示多重广播功能群组组员名单；
-i或--interfaces：显示网络接口信息；
-l或--listening：显示监控中的服务器的Socket；
-M或--masquerade：显示伪装的网络连线；
-n或--numeric：直接使用ip地址，而不通过域名服务器；
-N或--netlink或--symbolic：显示网络硬件外围设备的符号连接名称；
-o或--timers：显示计时器；
-p或--programs：显示正在使用Socket的程序识别码和程序名称；
-r或--route：显示Routing Table；
-s或--statistice：显示网络工作信息统计表；
-t或--tcp：显示TCP传输协议的连线状况；
-u或--udp：显示UDP传输协议的连线状况；
-v或--verbose：显示指令执行过程；
-V或--version：显示版本信息；
-w或--raw：显示RAW传输协议的连线状况；
-x或--unix：此参数的效果和指定"-A unix"参数相同；
--ip或--inet：此参数的效果和指定"-A inet"参数相同。
```
4. 实例
 - 显示监听状态的TCP或者UDP端口
 ```
 [root@edc01 ~]# netstat -tl
 Active Internet connections (only servers)
 Proto Recv-Q Send-Q Local Address           Foreign Address         State      
 tcp        0      0 0.0.0.0:25324           0.0.0.0:*               LISTEN     
 tcp        0      0 0.0.0.0:sunrpc          0.0.0.0:*               LISTEN     
 tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN     
 tcp6       0      0 [::]:sunrpc             [::]:*                  LISTEN     
 tcp6       0      0 [::]:39057              [::]:*                  LISTEN     
 tcp6       0      0 [::]:36498              [::]:*                  LISTEN     
 tcp6       0      0 [::]:9075               [::]:*                  LISTEN     
 tcp6       0      0 [::]:6005               [::]:*                  LISTEN     
 tcp6       0      0 [::]:6006               [::]:*                  LISTEN       
 ```

  - 获取进程名、进程号以及用户 ID
  `-ep` 获得进程信息和用户名，使用`root`权限或者`root`用户才会显示所有的端口信息
  ```
  [root@edc01 ~]# netstat -tlep
  Active Internet connections (only servers)
  Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name    
  tcp        0      0 0.0.0.0:25324           0.0.0.0:*               LISTEN      omsagent   38470      7268/ruby           
  tcp        0      0 0.0.0.0:sunrpc          0.0.0.0:*               LISTEN      root       41286      1/systemd           
  tcp        0      0 0.0.0.0:ssh             0.0.0.0:*               LISTEN      root       36292      6771/sshd           
  tcp6       0      0 [::]:sunrpc             [::]:*                  LISTEN      root       41288      1/systemd           
  tcp6       0      0 [::]:39057              [::]:*                  LISTEN      infa       96617      12730/java          
  tcp6       0      0 [::]:36498              [::]:*                  LISTEN      infa       111864     12730/java          
  tcp6       0      0 [::]:9075               [::]:*                  LISTEN      infa       99657      13003/java          
  tcp6       0      0 [::]:6005               [::]:*                  LISTEN      infa       100432     12376/java    
  ```

  `-n`和`-e`一起使用将显示user ID
  ```
  [root@edc01 ~]# netstat -tlnep
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name    
tcp        0      0 0.0.0.0:25324           0.0.0.0:*               LISTEN      995        38470      7268/ruby           
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      0          41286      1/systemd           
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      0          36292      6771/sshd           
tcp6       0      0 :::6023                 :::*                    LISTEN      1000       536035     17031/java          
tcp6       0      0 :::6024                 :::*                    LISTEN      1000       538028     17031/java          
tcp6       0      0 :::8105                 :::*                    LISTEN      1000       541768     16899/java  
  ```
  - 打印网络接口详细信息
  使用`-ei`
  ```
  [root@edc01 ~]# netstat -ei
Kernel Interface table
  eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.7  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fe80::20d:3aff:fea3:d55c  prefixlen 64  scopeid 0x20<link>
        ether 00:0d:3a:a3:d5:5c  txqueuelen 1000  (Ethernet)
        RX packets 359495  bytes 214117131 (204.1 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 346667  bytes 4103009080 (3.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
  ```

  - 查看服务是否运行
配合`grep`查看服务,如ntp,http,https
```
[infa@edchadoop01 edc_hdp]$ netstat -aple|grep ntp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
udp        0      0 edchadoop01.ub4csk0:ntp 0.0.0.0:*                           ntp        39662      -                   
udp        0      0 localhost:ntp           0.0.0.0:*                           root       43055      -                   
udp        0      0 0.0.0.0:ntp             0.0.0.0:*                           root       43049      -                   
udp6       0      0 edchadoop01:ntp         [::]:*                              ntp        39663      -                   
udp6       0      0 localhost:ntp           [::]:*                              root       43056      -                   
udp6       0      0 [::]:ntp                [::]:*                              root       43050      -                   
```
