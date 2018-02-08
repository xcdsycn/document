# git hooks脚本执行的必要条件
1. 更改脚本的所有者为git.git
```shell
chown git.git update
```
2. 使其具有可执行权限 
```shell
chmod a+x update
```
3. 使/var/logs/对于git用户可写
```shell
chown git.git /var/logs
chmod 777 /var/logs
```
