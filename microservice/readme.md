# service monitor
- 1.single server monitor tool: Nagios ,monitor the machine's status.
- 2.Nagios允许我们即看全部主机总体状态，也可以查看某台主机的状态。
- 3. ssh-multiplexers 在多个主机上运行相同的命令，用一个 grep "Error" app.log可以定位错误；
- 4.分布式日志的主要工作是收集尽可能多的日志信息到我们手上。
- 5.收取日志的工具：logstash是收集日志的工具，kibana是查看日志的工具；
- 6.指标：就是应用服务的业务监控。收集足够长时间的指标数据，然后总结出模式。避免不必要的紧张。
- 7.整个系统的聚合指标，需要关联指标的元数据,Graphite是一个实现业务指标跟踪的工具，类似于knowing系统。分析系统的趋势。
- 8.linux系统上的collectd向Graphite发送指标数据，会有大量的指标。
- 9.公开自己的服务指标，错误率和响应时间对于微服务来说是强烈要求暴露的。
- 10.某个功能使用的次数统计，可以看出系统的使用情况，功能设计是否是用户需要的。
- 11.最好是暴露一切数据。
- 12.综合监控：系统是否正常工作？一次事情的开始的ID，需要传过来，然后用于定位问题，与OMG类似。
- 13.合成监控，监控服务之间的问题。
- 14.每个服务实例都应该追踪和显示下游服务的健康状态(hystrix)，从数据库到其它合作服务，并将这些信息汇总。
- 15.标准化度量指标的名称。
