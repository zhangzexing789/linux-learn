# 变量
 - 定义变量时等号两边都不能接空格
 `test =shell`将报错
 - 可以使用单引号`''`或者双引号`""`定义带空格的变量
    - 双引号内的特殊字符如 $ 等，可以保有原本的特性 ，如
` var="lang is $LANG" `则` echo $var `可得` lang is zh_TW.UTF 8 `
    - 单引号内的特殊字符则仅为一般字符 纯文本 ))，如
`var='lang is $LANG'`  则`echo $var`  可得`lang is $LANG`
 - 使用转义字符`\`转移特殊符号，如[enter],$,\,空格,'',""等
```
hostname:username:/user/aappa01> test=shell\ hello
hostname:username:/user/aappa01> echo $test
shell hello
```
 - 增加变量内容
 `test=$test!` 则 `echo $test`可得`shell hello!`
 - 若该变量需要在其他子程序执行，则 需要以 export 来使变量变成环境变量
 - 取消变量的方法为使用 unset ：`unset 变量名称`例如取消

# 变量的分类
 - 内部变量：系统提供，不用定义，不能修改
 ```
 $n     $1 表示第一个参数，$2 表示第二个参数 ...
 $#     命令行参数的个数
 $0     当前程序的名称
 $?     前一个命令或函数的返回码
 $*     以"参数1 参数2 ... " 形式保存所有参数
 $@     以"参数1" "参数2" ... 形式保存所有参数
 $$     本程序的(进程ID号)PID
 ```
 - 环境变量：系统提供，不用定义，可以修改,可以利用export将用户变量转为环境变量.
 有以下两部分：
    - 系统设置：HOME,LOGNAME,MAIL,PATH,PS1,PWD,SHELL,TERM等
    - 用户设置，由export命令导出的
 - 用户变量（私有变量,本地变量）：用户定义，可以修改

# 变量命令
 - set：显示当前 Shell 所有变量，包括其内建环境变量（与 Shell 外观等相关），用户自定义变量及导出的环境变量，即包含了 env 和 export 命令的变量。
 - env：显示当前用户的环境变量
 - export：显示(设置)当前导出成环境变量的shell变量(注意：export为bash或类bash私有的命令)
 - unset 删除变量
 - readonly 将变量变为只读，所以无法删除

 ```
 [root@linux ~]# aaa=bbb            #声明变量并赋值
 [root@linux ~]# echo $aaa          #显示变量值
 bbb
 [root@linux ~]# set|grep aaa       #查找并显示指定shell变量
 aaa=bbb
 [root@linux ~]# env|grep aaa       #这里找不到，因为还未声明为环境变量
 [root@linux ~]# export aaa         #声明为环境变量
 [root@linux ~]# env|grep aaa       #找到了
 aaa=bbb
 [root@linux ~]# readonly aaa       #将变量aaa变成只读
 [root@linux ~]# unset aaa
-bash: unset: aaa: cannot unset: readonly variable  #删除报错

 ```

# 命令的执行顺序
 a. 以相对 绝对路径执行指令，例如『 /bin/ls 』或『 ./ls 』；
 b. 由 alias 找到该指令来执行；
 c. 由 bash 内建的 (builtin) 指令来执行；
 d. 透过 $PATH 这个变量的顺序搜寻到的第一个指令来执行。

 ```
[dmtsai@study ~]$ alias echo='echo -n'
[dmtsai@study ~]$ type -a echo
echo is aliased to `echo -n'
echo is a shell builtin
echo is /usr/bin/echo
 ```
 以上的echo命令就是按照alias，builtin，$PATH的顺序去查找echo指令

# 编辑 .profile 文件出生成 .profile.swp 文件

 由于vi /etc/profile还没有编辑完成，保存退出，突然断电 或其他原因导致编辑窗口关闭了，系统为保护文件，产生一个备份文件/etc/.profile.swp，保存着上次未保存时的文件状态，在下次使用vi打开/etc/profile就会读取到/etc/.profile.swp出现这种警告。

 也就出现了以下选项：
 - [O]pen Read-Only, 只读
 - [E]pdit anyway    强制进入编辑
 - [R]ecover,    恢复到上次未保存状态
 - [D]elete it,  直接删除/etc/.profile.swp，
 - [Q]uit, 退出
 - [A]bort:  中断

 选择操作后要删除.profile.swp 文件。

 5.查看linux 版本
 - 内核版本
 `uname -a`或者`cat /proc/version`
 - 系统版本
 `lsb_release -a `


 # 开启防火墙

使用命令行工具`firewall-cmd`进行管理
 - 默认已安装或者root用户使用`yum install -y firewalld`进行安装
 - 启用在开机启动防火墙
 ```
systemctl enable firewalld
 ```
 - 重启
 ```
systemctl restart firewalld
 ```
 - 检查防火墙状态
 ```
systemctl status firewalld.service
 ```
 - 启动
 ```
systemctl start firewalld.service
 ```
 - 停止
 ```
 systemctl stop firewalld.service
 ```
 - 列出允许的服务
 ```
firewall-cmd --list-services
 ```
 - 列出允许的端口
 ```
 firewall-cmd --list-ports
 ```
 - 启用服务的所有传入端口
```
firewall-cmd --permanent --zone=public --add-service=http
```
remember to restart firewall service
 - 开启指定端口                                                                      
```
firewall-cmd --permanent --zone=public --add-port=2222/tcp
```

# /etc/hosts , /etc/hostname 和 /etc/sysconfig/network

- /etc/hostname和/etc/sysconfig/network用于修改主机名，hostname直接用newhostname替换，network则修改HOSTNAME=NEWNAME，需要重启系统。
- /etc/hosts 是域名解析文件

[出现配置hosts文件也能修改hostname](https://www.jb51.net/LINUXjishu/77534.html)

# `su` 与 `sudo` (swich user) 切换用户
 - `su - `
是`su -l`的缩写，后面接将切换的用户名，不写则默认使用root用户,通过命令`exit`或`logout`，或者是快捷键Crtl+D即可返回原用户身份。`su`也需要该用户加入组`wheel`才有效，否则切换时将不成功并且报错`su: Permission denied`。

 - `su -`和`su`
su - USERNAME切换用户后，同时切换到新用户的工作环境中
su USERNAME切换用户后，不改变原用户的工作目录，及其他环境变量目录

 - `sudo`
是无须登录root，也不需要root密码即可执行root命令，root用户通过使用visudo命令编辑sudo的配置文件/etc/sudoers，才可以授权其他普通用户执行sudo命令。

 [参考链接](https://www.cnblogs.com/xd502djj/p/6641475.html)

# 使用vim 查看和文件编码转换
  - 查看：`:set fileencoding`
  - 转换为utf-8：`:set fileencoding=utf-8`

