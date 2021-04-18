# groupadd

## 选项

```txt

-g：指定新建工作组的id；
-r：创建系统工作组，系统工作组的组ID小于500；
-K：覆盖配置文件“/ect/login.defs”；
-o：允许添加组ID号不唯一的工作组。

```

## 相关文件

- /etc/group 组账户信息。
- /etc/gshadow 安全组账户信息。
- /etc/login.defs Shadow密码套件配置。

## 文件login.defs

```shell
#
# Please note that the parameters in this configuration file control the
# behavior of the tools from the shadow-utils component. None of these
# tools uses the PAM mechanism, and the utilities that use PAM (such as the
# passwd command) should therefore be configured elsewhere. Refer to
# /etc/pam.d/system-auth for more information.
#

# *REQUIRED*
#   Directory where mailboxes reside, _or_ name of file, relative to the
#   home directory.  If you _do_ define both, MAIL_DIR takes precedence.
#   QMAIL_DIR is for Qmail
#
#QMAIL_DIR      Maildir
MAIL_DIR        /var/spool/mail
#MAIL_FILE      .mail

# Password aging controls:
#
#       PASS_MAX_DAYS   Maximum number of days a password may be used.
#       PASS_MIN_DAYS   Minimum number of days allowed between password changes.
#       PASS_MIN_LEN    Minimum acceptable password length.
#       PASS_WARN_AGE   Number of days warning given before a password expires.
#
PASS_MAX_DAYS 90  #密码最长过期时间
PASS_MIN_DAYS 1  #密码最短过期时间
PASS_MIN_LEN    5 #密码最小长度
PASS_WARN_AGE 7  #密码过期提前提醒时间

#
# Min/max values for automatic uid selection in useradd
#
UID_MIN                  1000
UID_MAX                 60000
# System accounts
SYS_UID_MIN               201
SYS_UID_MAX               999

#
# Min/max values for automatic gid selection in groupadd
#
GID_MIN                  1000
GID_MAX                 60000
# System accounts
SYS_GID_MIN               201
SYS_GID_MAX               999

#
# If defined, this command is run when removing a user.
# It should remove any at/cron/print jobs etc. owned by
# the user to be removed (passed as the first argument).
#
#USERDEL_CMD    /usr/sbin/userdel_local

#
# If useradd should create home directories for users by default
# On RH systems, we do. This option is overridden with the -m flag on
# useradd command line.
#
CREATE_HOME     yes  #是否同时建立家目录

# The permission mask is initialized to this value. If not specified,
# the permission mask will be initialized to 022.
UMASK           077 #创建后用户的权限掩码

# This enables userdel to remove user groups if no members exist.
#
USERGROUPS_ENAB yes #创建用户时是否同时创建相同用户名的组

# Use SHA512 to encrypt password.
ENCRYPT_METHOD SHA512  #密码加密方式为SHA512

```
