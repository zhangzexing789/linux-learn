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
4. TCP连接状态
- CLOSED：初始状态，表示没有任何连接。
- LISTEN：Server端的某个Socket正在监听来自远方的TCP端口的连接请求。
- SYN_SENT：发送连接请求后等待确认信息。当客户端Socket进行Connect连接时，会首先发送SYN包，随即进入SYN_SENT状态，然后等待Server端发送三次握手中的第2个包。
- SYN_RECEIVED：收到一个连接请求后回送确认信息和对等的连接请求，然后等待确认信息。通常是建立TCP连接的三次握手过程中的一个中间状态，表示Server端的Socket接收到来自Client的SYN包，并作出回应。
- ESTABLISHED：表示连接已经建立，可以进行数据传输。
- FIN_WAIT_1：主动关闭连接的一方等待对方返回ACK包。若Socket在ESTABLISHED状态下主动关闭连接并向对方发送FIN包（表示己方不再有数据需要发送），则进入FIN_WAIT_1状态，等待对方返回ACK包，此后还能读取数据，但不能发送数据。在正常情况下，无论对方处于何种状态，都应该马上返回ACK包，所以FIN_WAIT_1状态一般很难见到。
- FIN_WAIT_2：主动关闭连接的一方收到对方返回的ACK包后，等待对方发送FIN包。处于FIN_WAIT_1状态下的Socket收到了对方返回的ACK包后，便进入FIN_WAIT_2状态。由于FIN_WAIT_2状态下的Socket需要等待对方发送的FIN包，所有常常可以看到。若在FIN_WAIT_1状态下收到对方发送的同时带有FIN和ACK的包时，则直接进入TIME_WAIT状态，无须经过FIN_WAIT_2状态。
- TIME_WAIT：主动关闭连接的一方收到对方发送的FIN包后返回ACK包（表示对方也不再有数据需要发送，此后不能再读取或发送数据），然后等待足够长的时间（2MSL）以确保对方接收到ACK包（考虑到丢失ACK包的可能和迷路重复数据包的影响），最后回到CLOSED状态，释放网络资源。
- CLOSE_WAIT：表示被动关闭连接的一方在等待关闭连接。当收到对方发送的FIN包后（表示对方不再有数据需要发送），相应的返回ACK包，然后进入CLOSE_WAIT状态。在该状态下，若己方还有数据未发送，则可以继续向对方进行发送，但不能再读取数据，直到数据发送完毕。
- LAST_ACK：被动关闭连接的一方在CLOSE_WAIT状态下完成数据的发送后便可向对方发送FIN包（表示己方不再有数据需要发送），然后等待对方返回ACK包。收到ACK包后便回到CLOSED状态，释放网络资源。
- CLOSING：比较罕见的例外状态。正常情况下，发送FIN包后应该先收到（或同时收到）对方的ACK包，再收到对方的FIN包，而CLOSING状态表示发送FIN包后并没有收到对方的ACK包，却已收到了对方的FIN包。有两种情况可能导致这种状态：其一，如果双方几乎在同时关闭连接，那么就可能出现双方同时发送FIN包的情况；其二，如果ACK包丢失而对方的FIN包很快发出，也会出现FIN先于ACK到达。


5. 实例
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
- 持续监控监听端口的启动情况
```
> netstat -ltc
```
- 查看某个端口或者IP的连接情况
```
> netstat -anp | grep 60008

(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp6       0      0 :::60008                :::*                    LISTEN      36337/java          
tcp6       0      0 10.238.18.4:60008       10.238.16.132:49430     ESTABLISHED 36337/java          
tcp6       0      0 10.238.18.4:60008       10.238.16.132:49319     TIME_WAIT   -                   
tcp6       0      0 10.238.18.4:60008       10.238.16.145:62421     ESTABLISHED 36337/java          
tcp6       0      0 10.238.18.4:60008       10.238.16.145:62755     ESTABLISHED 36337/java          
tcp6       0      0 10.238.18.4:60008       10.238.16.132:64724     ESTABLISHED 36337/java          
tcp6       0      0 10.238.18.4:60008       10.238.16.132:64942     ESTABLISHED 36337/java          
tcp6       0      0 10.238.18.4:60008       10.238.16.145:62420     ESTABLISHED 36337/java
```
- 统计TCP连接数

```
> netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

ESTABLISHED 751
TIME_WAIT 789

```
或者
```
> ss -s

Total: 1453 (kernel 0)
TCP:   1540 (estab 751, closed 725, orphaned 0, synrecv 0, timewait 721/0), ports 0

```

