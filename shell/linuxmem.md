# linux 查看内存使用情况
## 1 查看使用内存最多的20个进程
```
 ps aux | head -1;ps aux | grep -v PID | sort -rn -k +4 | head -20
`` 
## 2 查看进程使用的实际内存
```
ps -eo  size,pid,user,command --sort -size | awk '{hr=$1/1024;printf("%13.2f Mb ", hr)} {for(x=4; x<=NF; x++){printf("%s ",$x)"} print ""}' | cut -d "" -f2 | cut -d "-" -f1
```
## 3 smem 工具查看
需要先装 smem
```
yum install smem
smem -rs pss
```
## pmap 
```
pmap pid
pmap -x pid
```
## python 计算内存
可以在网上查一下看看
