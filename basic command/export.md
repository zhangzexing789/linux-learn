# export

## 功能

用于将shell 变量（或者函数）输出为环境变量。
当一个shell 脚本被调用时，脚本是没有权限访问调用者定义的变量的，也就是变量是不会自动被后续创建的shell进程获取的。除了变量设置为可用。export命令就可以实现向后续进程传递变量的功能。

## 用法

export(选项)(参数)

## 选项

- `-f`：代表[变量名称]中为函数名称；
- `-n`：删除指定的变量。变量实际上并未删除，只是不会输出到后续指令的执行环境中；
- `-p`：列出所有的shell赋予程序的环境变量。

## 参数

变量：指定要输出或者删除的环境变量。

## 实例

- 不加选项和参数，是查看已经存在的环境变量
  
  ```shell
  ASNPHTL@CIGWKL7251BVV ~
  $ export
  declare -x ALLUSERSPROFILE="C:\\ProgramData"
  declare -x APPDATA="C:\\Users\\asnphtl\\AppData\\Roaming"
  declare -x COMMONPROGRAMFILES="C:\\Program Files\\Common Files"
  ```

- 为后续shell进程输出变量
  
  ```shell
    ASNPHTL@CIGWKL7251BVV ~
    $ export a=b

    #再用export
    ASNPHTL@CIGWKL7251BVV ~
    $ export
    declare -x a="b"
    #这里仅仅是临时的环境变量
  ```
  
- 删除变量（并不是真正删除，起到屏蔽作用）
  
  ```shell
    ASNPHTL@CIGWKL7251BVV ~
    $ export -n a

    #再用export,将获取不到变量a
  ```
