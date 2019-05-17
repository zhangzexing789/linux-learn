1. 功能

连接文件并打印到标准输出设备上，cat经常用来显示文件的内容，类似于下的type命令。

注意：当文件较大时，文本在屏幕上迅速闪过（滚屏），用户往往看不清所显示的内容。
- 因此，一般用more等命令分屏显示。
- 为了控制滚屏，可以按Ctrl+S键，停止滚屏；
- 按Ctrl+Q键可以恢复滚屏。
- 按Ctrl+C（中断）键可以终止该命令的执行，并且返回Shell提示符状态。

2. 用法

cat (选项)（参数）

3. 选项

```
-n或-number：有1开始对所有输出的行数编号；
-b或--number-nonblank：和-n相似，只不过对于空白行不编号；
-s或--squeeze-blank：当遇到有连续两行以上的空白行，就代换为一行的空白行；
-A：显示不可打印字符，行尾显示“$”；
-e：等价于"-vE"选项；
-t：等价于"-vT"选项；
```

4. 参数
需要连接文件列表

5. 实例

```
cat m1 -n（在屏幕上显示文件ml的内容，并显示行数）
cat m1 m2 （同时显示文件ml和m2的内容）
cat m1 m2 > file （将文件ml和m2合并后放入文件file中）
cat m1 |grep test -n (显示test所在行的内容，并显示其行数)
```