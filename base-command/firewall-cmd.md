# firewall-cmd

firewalld跟iptables比起来至少有两大好处：

- firewalld可以动态修改单条规则，而不需要像iptables那样，在修改了规则后必须得全部刷新才可以生效。
- firewalld在使用上要比iptables人性化很多，即使不明白“五张表五条链”而且对TCP/ip协议也不理解也可以实现大部分功能

## 服务管理

```shell

yum install -y firewalld firewall-config #安装
systemctl start  firewalld # 启动
systemctl status firewalld # 或者 firewall-cmd --state 查看状态
systemctl disable firewalld # 停止
systemctl stop firewalld  # 禁用
systemctl restart firewalld # 重启

```

## 端口管理

```shell

# 打开443/TCP端口
firewall-cmd --add-port=443/tcp

# 永久打开3690/TCP端口
firewall-cmd --permanent --add-port=3690/tcp

# 永久打开端口需要reload 或者 restart firewalld
firewall-cmd --reload

# 查看防火墙，添加的端口也可以看到
firewall-cmd --list-all

```

## 域管理

```shell

firewall-cmd --get-default-zone #查看默认域
firewall-cmd --get-active-zones #查看当前生效域的状态
firewall-cmd -get-zones #查看存在的所有域
firewall-cmd --set-default-zone=public # 设置默认接口的域

firewall-cmd --get-zone-of-interface=eth0  # 查看指定接口所属区域
firewall-cmd --zone=public --add-interface=eth0 # 将接口添加到区域，默认接口都在public
# 永久生效再加上 --permanent 然后reload防火墙

firewall-cmd --zone=public --list-all #查看域所有信息
firewall-cmd --zone=public --list-ports # 查看域打开的端口
firewall-cmd --zone=public --add-port=8080/tcp # 添加端口到区域
firewall-cmd --zone=public --add-service=smtp #添加服务到区域
firewall-cmd --zone=public --remove-service=smtp #移除服务到区域

firewall-cmd --panic-on  # 拒绝所有包
firewall-cmd --panic-off  # 取消拒绝状态
firewall-cmd --query-panic  # 查看是否拒绝

```
