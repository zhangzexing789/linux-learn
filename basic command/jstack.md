# jstack
## 用法
```
Usage:
    jstack [-l] <pid>
        (to connect to running process) 连接活动线程
    jstack -F [-m] [-l] <pid>
        (to connect to a hung process) 连接阻塞线程
    jstack [-m] [-l] <executable> <core>
        (to connect to a core file) 连接dump的文件
    jstack [-m] [-l] [server_id@]<remote server IP or hostname>
        (to connect to a remote debug server) 连接远程服务器

Options:
    -F  to force a thread dump. Use when jstack <pid> does not respond (process is hung)
    -m  to print both java and native frames (mixed mode)
    -l  long listing. Prints additional information about locks
    -h or -help to print this help message
```
- 用于生成java虚拟机当前时刻的线程快照。线程快照是当前java虚拟机内每一条线程正在执行的方法堆栈的集合，生成线程快照的主要目的是定位线程出现长时间停顿的原因，如线程间死锁、死循环、请求外部资源导致的长时间等待等。 线程出现停顿的时候通过jstack来查看各个线程的调用堆栈，就可以知道没有响应的线程到底在后台做什么事情，或者等待什么资源。

## 线程状态
- `NEW`,未启动的。不会出现在Dump中。
- `RUNNABLE`,在虚拟机内执行的。运行中状态，可能里面还能看到locked字样，表明它获得了某把锁。
- `BLOCKED`,受阻塞并等待监视器锁。被某个锁(synchronizers)給block住了。
- `WATING`,无限期等待另一个线程执行特定操作。等待某个condition或monitor发生，一般停留在park(), wait(), sleep(),join() 等语句里。
- `TIMED_WATING`,有时限的等待另一个线程的特定操作。和WAITING的区别是wait() 等语句加上了时间限制 wait(timeout)。
- `TERMINATED`,已退出的。

## 线程调用修饰词
- locked <地址> :使用synchronized申请对象锁成功,监视器的拥有者。
```
at oracle.jdbc.driver.PhysicalConnection.prepareStatement
- locked <0x00002aab63bf7f58> (a oracle.jdbc.driver.T4CConnection)
at oracle.jdbc.driver.PhysicalConnection.prepareStatement
- locked <0x00002aab63bf7f58> (a oracle.jdbc.driver.T4CConnection)
at com.jiuqi.dna.core.internal.db.datasource.PooledConnection.prepareStatement
```
- waiting to lock <地址> : 通过synchronized关键字,没有获取到了对象的锁,线程在监视器的进入区等待。在调用栈顶出现,线程状态为Blocked。
```
at com.jiuqi.dna.core.impl.CacheHolder.isVisibleIn(CacheHolder.java:165)
- waiting to lock <0x0000000097ba9aa8> (a CacheHolder)
```
- waiting on <地址>: 通过synchronized关键字,成功获取到了对象的锁后,调用了wait方法,进入对象的等待区等待。在调用栈顶出现,线程状态为WAITING或TIMED_WATING。
- parking to wait for <地址> ： park是基本的线程阻塞原语,不通过监视器在对象上阻塞。

## 实例
- 统计线程数
```
jstack -l 28367 | grep 'java.lang.Thread.State' | wc -l
```
- 检查CPU高的进程状态
    1. top查找出哪个进程消耗的cpu高。执行top命令，默认是进程视图，其中PID是进程号。这里分析进程`21125`
    ```
    21125 co_ad2    18   0 1817m 776m 9712 S  3.3  4.9  12:03.24 java                                                                                           
    5284 co_ad     21   0 3028m 2.5g 9432 S  1.0 16.3   6629:44 ja
    ```
    这里我们分析21125这个java进程
    2. top中shift+h 或“H”查找出哪个线程消耗的cpu高。
    先输入top，然后再按shift+h 或“H”，此时打开的是线程视图，pid为线程号
    ```
    21233 co_ad2    15   0 1807m 630m 9492 S  1.3  4.0   0:05.12 java                                                                                           
    20503 co_ad2_s  15   0 1360m 560m 9176 S  0.3  3.6   0:46.72 java                                                                                           
    ```
    这里我们分析`21233`这个线程，并且注意的是，这个线程是属于`21125`这个进程的。 

    3. 使用jstack命令输出这一时刻的线程栈，保存到文件，命名为jstack.log。注意：输出线程栈和保存top命令快照尽量同时进行。由于jstack.log文件记录的线程ID是16进制，需要将top命令展示的线程号转换为16进制。
    ```
    printf "%x\n" 21233
    52f1
    ```
    4. jstack查找这个线程的信息。
    jstack [进程]|grep -A 10 [线程的16进制] 即： `jstack 21125|grep -A 10 52f1` -A 10表示查找到所在行的后10行。
    ```
    "http-8081-11" daemon prio=10 tid=0x00002aab049a1800 nid=0x52f1 in Object.wait() [0x0000000042c75000]  
    java.lang.Thread.State: WAITING (on object monitor)  
        at java.lang.Object.wait(Native Method)  
        at java.lang.Object.wait(Object.java:485)  
        at org.apache.tomcat.util.net.JIoEndpoint$Worker.await(JIoEndpoint.java:416)  
    ```
