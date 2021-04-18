# su 与 sudo 切换用户

- `su - `

是`su -l`的缩写，后面接将切换的用户名，不写则默认使用root用户,通过命令`exit`或`logout`，或者是快捷键Crtl+D即可返回原用户身份。`su`也需要该用户加入组`wheel`才有效，否则切换时将不成功并且报错`su: Permission denied`。

- `su -`和`su`

su - USERNAME切换用户后，同时切换到新用户的工作环境中
su USERNAME切换用户后，不改变原用户的工作目录，及其他环境变量目录

- `sudo`

是无须登录root，也不需要root密码即可执行root命令，root用户通过使用visudo命令编辑sudo的配置文件/etc/sudoers，才可以授权其他普通用户执行sudo命令。

 [参考链接](https://www.cnblogs.com/xd502djj/p/6641475.html)