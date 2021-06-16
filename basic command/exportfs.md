# exportfs

如果修改了/etc/exports文件后不需要重新激活nfs，只要重新扫描一次/etc/exports文件，并且重新将设定加载即可：
# exportfs [-aruv]
参数说明如下。
1）-a：全部挂载（或卸载）/etc/exports文件内的设定。
2）-r：重新挂载/etc/exports中的设置，此外同步更新/etc/exports及/var/lib/nfs/xtab中的内容。
3）-u：卸载某一目录。
4）-v：在export时将共享的目录显示在屏幕上。
5) -i: 忽略/etc/exports配置文件，只使用exportfs指令的默认值和命令行指定的参数

下面是一些NFS共享的常用参数：
ro                      只读访问  
rw                      读写访问  
sync                    所有数据在请求时写入共享  
async                   NFS在写入数据前可以相应请求  
secure                  NFS通过1024以下的安全TCP/IP端口发送  
insecure                NFS通过1024以上的端口发送  
wdelay                  如果多个用户要写入NFS目录，则归组写入（默认）  
no_wdelay               如果多个用户要写入NFS目录，则立即写入，当使用async时，无需此设置。  
hide                    在NFS共享目录中不共享其子目录  
no_hide                 共享NFS目录的子目录  
subtree_check           如果共享/usr/bin之类的子目录时，强制NFS检查父目录的权限（默认）  
no_subtree_check        和上面相对，不检查父目录权限  
all_squash              共享文件的UID和GID映射匿名用户anonymous，适合公用目录。  
no_all_squash           保留共享文件的UID和GID（默认）  
root_squash             root用户的所有请求映射成如anonymous用户一样的权限（默认）  
no_root_squash          root用户具有根目录的完全管理访问权限  
anonuid=xxx 指定NFS服务器/etc/passwd文件中匿名用户的UID  
anongid=xxx 指定NFS服务器/etc/passwd文件中匿名用户的GID 