1. 变量
 - 定义变量时等号两边都不能接空格
 `test =shell`将报错
 - 可以使用单引号`''`或者双引号`""`定义带空格的变量
    - 双引号内的特殊字符如 $ 等，可以保有原本的特性 ，如
` var="lang is $LANG" `则` echo $var `可得` lang is zh_TW.UTF 8 `
    - 单引号内的特殊字符则仅为一般字符 纯文本 ))，如
`var='lang is $LANG'`  则`echo $var`  可得`lang is $LANG`
 - 使用转义字符`\`转移特殊符号，如[enter],$,\,空格,'',""等
```
thadcdlifc01:aappa01:/user/aappa01> test=shell\ hello
thadcdlifc01:aappa01:/user/aappa01> echo $test
shell hello
```
 - 增加变量内容
 `test=$test!` 则 `echo $test`可得`shell hello!`
 - 若该变量需要在其他子程序执行，则 需要以 export 来使变量变成环境变量
 - 取消变量的方法为使用 unset ：`unset 变量名称`例如取消

 2. 命令的执行顺序
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

 3. 
