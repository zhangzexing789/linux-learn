# 环境配置文件
## login 与 non-login shell
### login shell
就是需要通过账号密码登录。

### non-login shell
- 应用程序已经登录，登录终端机界面无需账号密码
- 终端机界面已经登录，使用`bash`打开另一个界面，即子程序

## login shell 加载的配置文件
- /etc/profile ：这是系统整体的配置文件，最好不要修改
- ~/.bash_profile 或 ~/.bash_login 或 ~/.profile ：当前账户的配置文件

### 全局配置文件--针对所有用户
#### 包含的变量
- PATH ：会依据 UID 决定 PATH 变量要不要含有 sbin 的系统指令目录；
- MAIL ：依据账号设定好使用者的 mailbox 到指定路径下 /var/spool/ 账号名；
- USER ：根据用户的账号设定此一变量内容或者指定读取的文件路径；
- HOSTNAME ：依据主机的 hostname 指令决定此一变量内容或者指定读取的文件路径；
- HISTSIZE ：历史命令记录笔数。 CentOS 7.x 设定为 1000
- umask ：包括 root 默认为 022 而一般用户为 002 等！

#### 由该文件外呼读取的其他配置文件
- /etc/profile.d/\*.sh
 即当前用户对该路径下的sh文件有 `r` 权限时，将读取所有的sh文件。目录底下的文件规范了 bash 操作接口的颜色、 语系、ll 与 ls 指令的命令别名、vi 的命令别名、which 的命令别名等等。
在该目录增加命令别名文件即可实现用户共享。

-  /etc/locale.conf
由 /etc/profile.d/lang.sh 外呼读取进来的。配置变量`LANG`或者`LC_ALL`即可配置系统的编码。

- /usr/share/bash completion/completions/*
由 /etc/profile.d/bash_completion.sh 外呼读取进来。对指令的选项/参数补齐功能的配置。

### 用户配置文件
1. ~/.bash_profile
2. ~/.bash_login
3. ~/.profile
按照顺序读取其中一个文件。

```
[dmtsai@study ~]$ cat ~/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then     <==底下这三行在判断并读取 ~/.bashrc
        . ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin <==底下这几行在处理个人化设定
export PATH
```
即使在/etc/profile配置文件中已经设定了PATH变量，这里依然可以设定当前用户的PATH变量，并将其累加到全局PATH变量中去。

## non-login shell 加载的配置文件
- 仅加载文件 ~/.bashrc

## /etc/bashrc 或者 ~/.bashrc -- 系统自动加载的配置文件
### 文件作用
-  依据不同的 UID 规范出 umask 的值；
-  依据不同的 UID 规范出提示字符 就是 PS1 变量
-  呼叫 /etc/profile.d/\*.sh 的设定

### PS1变量

```
thadcdlifc01:aappa01:/user/aappa01> echo $PS1
${HOSTNAME}:${LOGNAME}:${PWD}>
```
有以下设置
```
\d ：代表日期，格式为weekday month date
\H ：完整的主机名
\h ：主机的第一个名字
\t ：显示时间为24小时格式(HH:MM:SS)
\T ：显示时间为12小时格式
\A ：显示时间为24小时格式(HH:MM)
\u ：当前用户的账户名
\v ：BASH的版本信息
\w ：完整的工作目录名
\W ：利用basename取得工作目录名称，所以只会列出最后一个目录
\# ：第几个命令
\$ ：提示字符，如果是root时，提示符为：#;普通用户为：$

//颜色表
前景   背景   颜色
30     40    黑色
31     41    红色
32     42    绿色
33     43    黄色
34     44    蓝色
35     45    紫红色
36     46    青蓝色
37     47    白色

//其他
0            OFF
1            高亮显示
4            underline            
7            反白显示
8            不可见
```
