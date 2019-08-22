
OPTIONS
```
-a, --alias
Display the alias name of the host (if used).

-d, --domain(显示DNS域名，建议使用另一个命令dnsdomainname)
Display the name of the DNS domain. Don't use the command domainname to get the DNS domain name because it will show the NIS domain name and not the DNS domain name. Use dnsdomainname instead.

-F, --file filename
Read the host name from the specified file. Comments (lines starting with a `#') are ignored.

-f, --fqdn, --long(修改须同时配置/etc/hosts和/etc/sysconfig/network，如果存在的话)
Display the FQDN (Fully Qualified Domain Name). A FQDN consists of a short host name and the DNS domain name. Unless you are using bind or NIS for host lookups you can change the FQDN and the DNS domain name (which  is  part  of  the  FQDN)  in  the /etc/hosts file.

-h, --help
Print a usage message and exit.

-i, --ip-address
Display the IP address(es) of the host.

-n, --node
Display the DECnet node name. If a parameter is given (or --file name ) the root can also set a new node name.

-s, --short
Display the short host name. This is the host name cut at the first dot.

-V, --version
Print version information on standard output and exit successfully.

-v, --verbose
Be verbose and tell what's going on.
```