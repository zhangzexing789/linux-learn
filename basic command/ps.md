# PS

## 功能

用于对系统进程状态的查看。

## 用法

ps (选项)

## 选项

```shell
-a：显示所有终端机下执行的程序，除了阶段作业领导者之外。
a：显示现行终端机下的所有程序，包括其他用户的程序。
-A：显示所有程序。
-c：显示CLS和PRI栏位。
c：列出程序时，显示每个程序真正的指令名称，而不包含路径，选项或常驻服务的标示。
-C<指令名称>：指定执行指令的名称，并列出该指令的程序的状况。
-d：显示所有程序，但不包括阶段作业领导者的程序。
-e：此选项的效果和指定"A"选项相同。
e：列出程序时，显示每个程序所使用的环境变量。
-f：显示UID,PPIP,C与STIME栏位。
f：用ASCII字符显示树状结构，表达程序间的相互关系。
-g<群组名称>：此选项的效果和指定"-G"选项相同，当亦能使用阶段作业领导者的名称来指定。
g：显示现行终端机下的所有程序，包括群组领导者的程序。
-G<群组识别码>：列出属于该群组的程序的状况，也可使用群组名称来指定。
h：不显示标题列。
-H：显示树状结构，表示程序间的相互关系。
-j或j：采用工作控制的格式显示程序状况。
-l或l：采用详细的格式来显示程序状况。
L：列出栏位的相关信息。
-m或m：显示所有的执行绪。
n：以数字来表示USER和WCHAN栏位。
-N：显示所有的程序，除了执行ps指令终端机下的程序之外。
-p<程序识别码>：指定程序识别码，并列出该程序的状况。
p<程序识别码>：此选项的效果和指定"-p"选项相同，只在列表格式方面稍有差异。
r：只列出现行终端机正在执行中的程序。
-s<阶段作业>：指定阶段作业的程序识别码，并列出隶属该阶段作业的程序的状况。
s：采用程序信号的格式显示程序状况。
S：列出程序时，包括已中断的子程序资料。
-t<终端机编号>：指定终端机编号，并列出属于该终端机的程序的状况。
t<终端机编号>：此选项的效果和指定"-t"选项相同，只在列表格式方面稍有差异。
-T：显示现行终端机下的所有程序。
-u<用户识别码>：此选项的效果和指定"-U"选项相同。
u：以用户为主的格式来显示程序状况。
-U<用户识别码>：列出属于该用户的程序的状况，也可使用用户名称来指定。
U<用户名称>：列出属于该用户的程序的状况。
v：采用虚拟内存的格式显示程序状况。
-V或V：显示版本信息。
-w或w：采用宽阔的格式来显示程序状况。
x：显示所有程序，不以终端机来区分。
X：采用旧式的Linux i386登陆格式显示程序状况。
-y：配合选项"-l"使用时，不显示F(flag)栏位，并以RSS栏位取代ADDR栏位　。
-<程序识别码>：此选项的效果和指定"p"选项相同。
--cols<每列字符数>：设置每列的最大字符数。
--columns<每列字符数>：此选项的效果和指定"--cols"选项相同。
--cumulative：此选项的效果和指定"S"选项相同。
--deselect：此选项的效果和指定"-N"选项相同。
--forest：此选项的效果和指定"f"选项相同。
--headers：重复显示标题列。
--help：在线帮助。
--info：显示排错信息。
--lines<显示列数>：设置显示画面的列数。
```

## 显示栏说明

```Linux
 [infa@edc01 bin]$ ps -l
F S   UID    PID   PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD

0 S  1000   7029   7028  0  80   0 - 29059 do_wai pts/0    00:00:00 bash
0 S  1000  99535      1  5  80   0 - 2904782 futex_ pts/0  00:12:40 java
0 S  1000  99766  99535  2  80   0 - 2731922 futex_ pts/0  00:06:16 java
0 S  1000 100661  99535  1  80   0 - 2777643 futex_ pts/0  00:03:37 java
0 S  1000 100925 100661  0  80   0 - 1174234 futex_ pts/0  00:00:11 java
0 S  1000 101090  99535  2  80   0 - 2956385 futex_ pts/0  00:05:41 java
0 S  1000 101467  99535  0  80   0 - 2114694 futex_ pts/0  00:01:10 java
0 R  1000 116594   7029  0  80   0 - 38309 -      pts/0    00:00:00 ps
```

- F：代表这个进程标志（process flags），说明这个进程的权限
  - 4表示此进程的权限为root；
  - 1表示此子进程仅可进行复制（fork）而无法执行（exec）；
- S：代表这个进程的状态（STAT),主要的状态有：

  - R（Running）：该进程正在运行中；  

  - S（Sleep）：该进程目前正在睡眠状态（idle），但可以被唤醒（signal）；  

  - D：不可被唤醒的状态，通常这个进程可能在等待I/O的情况（ex>打印）；  

  - T：停止状态（stop），可能是在工作控制（后台暂停）或出错（traced）状态；  

  - Z（Zombie）：“僵尸”状态，该进程已经终止但却无法被删除至内存外。  

- UID/PID/PPID:代表此进程被该UID所拥有的/进程的PID号码/此进程的父进程PID号码。  

- C：代表CPU使用率，单位为百分比。  

- PRI/NI：Priority/Nice的缩写，代表此进程被CPU所执行的优先级，数值越小代表此进程越快被CPU执行。  

- ADDR/SZ/WCHAN:都与内存有关，ADDR是kernel function,指出该进程在内存的哪个部分，如果是个running的进程，一般会显示“—”。SZ代表此进程用掉多少内存。WCHAN表示目前进程是否在运行中，同样，若为“—”表示正在运行中。  

- TTY：登录者的终端位置，若为远程登录使用动态终端接口（pts/n）。

- TIME:使用CPU的时间，注意，是此进程实际花费CPU运行的时间，而不是系统时间。

- CMD:就是command的缩写，造成此程序的触发进程的命令为何。
