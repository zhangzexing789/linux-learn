# swp 文件

编辑 .profile 文件出生成 .profile.swp 文件。

 由于vi /etc/profile还没有编辑完成，保存退出，突然断电 或其他原因导致编辑窗口关闭了，系统为保护文件，产生一个备份文件/etc/.profile.swp，保存着上次未保存时的文件状态，在下次使用vi打开/etc/profile就会读取到/etc/.profile.swp出现这种警告。

 也就出现了以下选项：
 - [O]pen Read-Only, 只读
 - [E]pdit anyway    强制进入编辑
 - [R]ecover,    恢复到上次未保存状态
 - [D]elete it,  直接删除/etc/.profile.swp，
 - [Q]uit, 退出
 - [A]bort:  中断

 选择操作后要删除.profile.swp 文件。