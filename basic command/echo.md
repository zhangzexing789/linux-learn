# echo

## 用法

```linux
echo 选项 参数
```

## 选项

```shell
-e 激活转义字符，使其生效
```

使用-e选项时，若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出：

- `\c` 最后不加上换行符号；
- `\f` 换行但光标仍旧停留在原来的位置；
- `\n` 换行且光标移至行首；
- `\r` 光标移至行首，但不换行；
- `\t` 插入tab；
- `\a` 发出警告声；
- `\v` 与\f相同；
- `\nnn` 插入nnn（八进制）所代表的ASCII字符；
- `\\` 插入\字符；
- `\b` 删除前一个字符；

## 参数

指定要打印的变量或者字符串

```shell
ASNPHTL@CIGWKL7251BVV ~
$ echo 'abc\nefg'
abc\nefg

ASNPHTL@CIGWKL7251BVV ~
$ echo -e 'abc\nefg'
abc
efg
```
