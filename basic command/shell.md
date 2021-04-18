# 系统管理命令
- top	进程内存状态-java 占用大量CPU
- ps -ef|grep java	查看java相关进程的具体线程息
- ps -ef|grep NODE_SIT	查看NODE_SIT相关程息
- man kill	帮助信息
- su - root	切换用户
- kill -9 进程ID 	强制关闭
- ps -e -o 'pid,comm,args,pcpu,rsz,vsz,stime,user,uid'
- ps -e -o 'pid,comm,args,rsz'


/root/bin

```
sh stopServer.sh  NODE_SIT( or use 'kill -9')
sh startServer.sh NODE_SIT
```

- stat              显示指定文件的详细信息，比ls更详细
- who               显示在线登陆用户
- whoami          显示当前操作用户
- hostname      显示主机名
- uname           显示系统信息（windows or Linux ）
- top                动态显示当前耗费资源最多进程信息
- ps                  显示瞬间进程状态 ps -aux
- du                  查看目录大小 du -h /home带有单位显示目录信息
- df                  查看磁盘大小 df -h 带有单位显示磁盘信息
- ifconfig          查看网络情况
- ping                测试网络连通
# 文件管理
- -gt是大于的意思。
- -eq是等于的意思。
- -ne是不等于的意思。
- -ge是大于等于的意思。
- -lt是小于的意思。
- -le是小于等于的意思。
- rem 注释
- touch filename.txt新建文件
- mkdir dirname 新建文件夹
- rm filename删除文件 -f 强制删除
   -r 递归删除目录或者文件
- rmdir dirname 删除空文件夹
- echo "hello" 打印文字内容到屏幕上
- mv  oldname newname 重命名或者移动文件
# 内容管理
## less 命令
- less 对任何文件进行分页查看，相比more，可以向前进行翻页
- 命令参数
```
-b 加<缓冲区大小>  设置缓冲区的大小
-e 当文件显示结束后，自动离开
-f 强迫打开特殊文件，例如外围设备代号、目录和二进制文件
-g 只标志最后搜索的关键词
-i 忽略搜索时的大小写
-m 显示类似more命令的百分比
-N 显示每行的行号
-o 加<文件名>  将less 输出的内容在指定文件中保存起来
-Q 不使用警告音
-s 显示连续空行为一行
-S 行过长时间将超出部分舍弃
-x 加<数字>   将“tab”键显示为规定的数字空格
```

- 浏览命令(less)
```
/字符串：向下搜索“字符串”的功能
？字符串：向上搜索“字符串”的功能
n：重复前一个搜索（与 / 或 ？ 有关）
N：反向重复前一个搜索（与 / 或 ？ 有关）
b 向后翻一页
d 向后翻半页
h 显示帮助界面
Q 退出less 命令
u 向前滚动半页
y 向前滚动一行
空格键 滚动一行
回车键 滚动一页
[pagedown]： 向下翻动一页
[pageup]： 向上翻动一页
ctrl + F ：向前移动一屏
ctrl + B ：向后移动一屏
ctrl + D ：向前移动半屏
ctrl + U ：向后移动半屏
q / ZZ ： 退出 less 命令
```
## find 命令

```
 . 列出当前目录及其子目录下所有文件和文件夹
 -path '*/joson/*' -name '*.txt'  列出目录“joson” 下所有 TXT 文件
 -path '*/joson/*' ！ -name '*.txt'  列出目录“joson” 下所有的不是 TXT 文件
 -iname 文件名忽略大小写
 -ls 显示详细信息
 -atime(天)，-amin（分钟）  文件最后一次被访问时间。 如：-atime 7 恰好在七天前访问的文件
 -mtime（天），-mmin（分钟）  文件最后一次被修改时间。 如： -mtime -7  在七天内被修改的文件
 -ctime（天），-cmin（分钟）  文件数据元（例如权限等）最后一次修改时间。 如：-ctime +7  超过七天被修改权限的文件
 -type 按文件类型搜索（f： 普通文件， l： 符号连接， d： 目录， c： 字符设备， b： 块设备， s： 套接字， p： Fifo）
 -size 按文件代销搜索（b —— 块（512字节） c —— 字节 w —— 字（2字节）k —— 千字节 M —— 兆字节 G —— 吉字节），同样的‘-’和‘+’表示范围，如 find -type f -size +10k 搜索文件大小大于10k的
 -delete 搜索匹配文件并删除
 -perm  匹配权限的文件，如 find -type f -perm 777 匹配权限是777的文件
 -user  匹配用户拥有的文件，如find -type f - user admin 匹配用户admin拥有的文件
 -group 匹配用户组拥有的文件

```
### find 命令的高级应用
-exec 当 find 结果为true时， 执行后面的命令 ，{} 表示搜索得到的结果
```
find .-type f -user root -exec chown tom {} \;    将root所属的文件变更其所有权为用户 tom
```
-ok 与 -exec 唯一的区别就是会进行提示，等进一步的确认
```
find . -name '*.txt' -ok rm {} \;     删除当前目录及其子目录下的txt文件

find . -type f -mtime +30 -name "*.log" -exec cp {} old \;     将30天前的.log文件移动到old 目录下
```
## awk 命令
- awk '{pattern + action}' {filenames}	其中 pattern 表示 AWK 在数据中查找的内容，而 action 是在找到匹配内容时所执行的一系列命令。
 花括号（{}）不需要在程序中始终出现，但它们用于根据特定的模式对一系列指令进行分组。 pattern就是要表示的正则表达式，用斜杠括起来。
 awk工作流程是这样的：读入有'\n'换行符分割的一条记录，然后将记录按指定的域分隔符划分域，填充域，$0则表示所有域,$1表示第一个域,$n表示第n个域。默认域分隔符是"空白键" 或 "[tab]键"。
 比如：awk  -F ':'  '{print $1}'  /etc/test.txt	-F指定域分隔符为':'，显示第一个域
| 	将一个命令的输出作为另外一个命令的输入。
 grep "hello" file.txt | wc -l
　 	在file.txt中搜索包含有”hello”的行并计算其行数。

## 其他命令
- grep 'patternStr' file 文件内搜索“patternStr”字符串
- cut -b colnum file: 指定欲显示的文件内容范围，并将它们输出到标准输出设备比如：输出
 每行第5个到第9个字符	cut -b5-9 file.txt
- cat 查看
- cp -f  强制复制，复制冲突（相同）内容
- sed -i 's/原字符串/新字符串/' /home/1.txt	替换字符串
- fi  表示if语句块的结束，用于bash脚本中
- file somefile 得到文件类型
- sort file.txt 对file.txt 文件的行进行排序(按ASCII码值进行比较)，there are result on console in the default,and the source file will not change.
```
   -b   忽略每行前面开始出的空格字符。
   -c   检查文件是否已经按照顺序排序。
   -f   排序时，忽略大小写字母。
   -M   将前面3个字母依照月份的缩写进行排序。example:JAN will ahead FEB
   -n   依照数值的大小排序。example:10 will not behind 2,but it will as default.
   -o<输出文件>   将排序后的结果存入指定的文件。
   -r   以相反的顺序来排序。
   -t<分隔字符>':'   指定排序时所用的栏位分隔字符。
   -k  选择以哪个区间进行排序。(0,1,2....)
```
- uniq 检查并去除重复行（相邻行），建议结合sort（去除所有的重复）， 使用sort -u命令进行不重复排序

- basename file 返回不包含路径的文件名比如： basename /bin/tux将返回 tux
- dirname file 返回文件所在路径比如：dirname /bin/tux将返回 /bin
- head file 打印文本文件开头几行
- tail file  打印文本文件末尾几行
- \> 	写入文件并覆盖旧文件
- \>> 	加到文件的尾部，保留旧文件内容。
```
[ ]  表示条件判断
  [ -f "somefile" ] ：判断是否是一个文件
  [ -x "/bin/ls" ] ：判断/bin/ls是否存在并有可执行权限
  [ -n "$var" ] ：判断$var变量是否有值
  [ "$a" = "$b" ] ：判断$a和$b是否相等
```
- case 匹配字符串
  case ... in
   ...) do something here ;;
  esac
- select 表达式是一种bash的扩展应用，尤其擅长于交互式使用。用户可以从一组不同的值中进行选择。
  select var in ... ; do
　	 break
  done
  .... now $var can be used ....
- for 循环
  for rpmpackage in $*; do       #rpmpackage 取出所有输入的每一个命令行参数值，$* 代表所有参数值
　		if [ -r "$rpmpackage" ];then  #判断是否可读
　　			echo "=============== $rpmpackage =============="  
　　			rpm -qi -p $rpmpackage  	#输出被安装的包的信息
　		else  
　　			echo "ERROR: cannot read file $rpmpackage"  
　		fi  
  done
- "" and ''	引号 (单引号和双引号) 用来防止通配符扩展，单引号还可以防止任何变量扩展；而双引号可以防止通配符扩展但允许变量扩展，即是保存了原有变量的真实含义
```
  name=TekTea
  echo $name
  #TekTea
  sayhello=”Hello $name”
  echo $sayhello
  #Hello TekTea
  sayhello='Hello $name' #相当于sayhello="Hello \$name"
  echo $sayhello
  #Hello $name
```
- Here Document
键盘输入(heredoc 在界面将会隐藏)

```
cat <<A
heredoc> 444
heredoc> 333
heredoc>A
屏幕将显示
444
333


cat <<A >test.txt	#写入内容并覆盖test.txt  >>写入内容到文件结尾
heredoc> 444
heredoc> 333
heredoc>A
```

- read var: 提示用户输入，并将输入赋值给变量
- let 运算操作，用于bash脚本中
- expr 进行数学运算 $expr 10 + 10  输出20
# shell 命令
