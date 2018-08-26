# 返回 cpu 总数
```bash
grep -c 'model name' /proc/cpuinfo
```
# 查看某个进程的 CPU 利用率
```bash
top -bH -p <pid> -n 1 | head -n10
stack
```
