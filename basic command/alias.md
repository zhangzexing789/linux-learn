# alias

## 功能

用于对命令进行设置别名。
alias命令的作用只局限于该次登入的操作。若要每次登入都能够使用这些命令别名，则可将相应的alias命令存放到bash的初始化文件`/etc/bashrc`中

## 用法

alias (选项)(参数)

要删除一个别名，可以使用 `unalias` 命令，如 `unalias l`

## 选项

```shell
不加参数：会列出当前系统中所有已经定义的命令别名
-p：打印已经设置的命令别名。
```

## 参数

命令别名=‘实际命令’

## 实例

- 列出所有已经设置别名的命令

 ```shell
[infa@edc01 10.2.1]$ alias
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lm='ls -al'
alias ls='ls --color=auto'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
 ```

- 设置别名

 ```shell
[infa@edc01 10.2.1]$ alias lm='ls -al'
 ```
