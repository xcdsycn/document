# 性能调优
## 性能定义
1. 什么让你觉得是一个性能问题
2. 系统 以前就这么差么
3. 最近改变了什么（软件、硬件、负载？）
- load : pid uid id
- 什么引起的load升高：code path ,stack trace
- load:IOPS, tput, type, r/w
- 负载是如何随时间变化的？
4. 性能问题是潜在的还是运行时的？
5. 这个问题影响其它人或程序了么？
6. 现在运行的环境是什么？程序的版本是什么？
7. USE
- 系统 的利用率，哪个是异常的？
- 系统 是否有ERROR Log，体现在调用链的什么位置？
8. 目前系统是否有监控，都有什么类型的监控？
9. 系统 的日志是如何存储的，是否有统一的日志存储分析平台？

## 性能现象排查
1. 以前就这么性能差么
2. 本次改动了什么
3. 先易后难，先用熟悉的工具，再用不熟悉的，从网上找的，运行，看结果
4. 查找显而易见的问题
5. 甩锅法，找出不是自己的问题，然后让别人去处理
