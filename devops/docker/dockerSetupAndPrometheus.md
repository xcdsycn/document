
install docker has to method:
1. install on a exist centos 7
2. with a tool called docker machine

# method 1
## Prerequisites
1. 64-bit centos7
2. No-root user with sudo
## docker compose


## 安装步骤
### 1 安装docker
1. remove docker
yum list installed | grep docker

2. install docker
```url
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7
```

### 2 安装Docker Compose
#### 简介
1. fig 用yaml来编排docker containers和配置
2. 基于fig做了Docker Compose
3. 用来方便container的启动、停止等
```
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-centos-7
```
#### 概念
1. docker images,每个Image用的是宿主操作系统的核心，如果container运行起来以后，用的是自己的文件系统，所以在centos运行ubuntu是可以的
2. 大多数的docker镜像都在dockerHub上，最好用docker official Images，因为是被docker team维护的
3. 在docker images之前通信，默认宿主机是不可以访问docker container的，这就使得配置、运行docker image中的应用困难
4. 有三种方法解决这个问题：1）指定container内的环境变量 2）docker data volume,指定内部volume，就是指定内部存储位置 3）网络 links,指定内外部的ports

#### 安装
1. 前提，在centos7上已装好了docker
2. install docker compose
3. docker compose 是一个目录一个container的，都是基于目录运行的，所以很容易维护container

### 3. install docker compose & prometheus
1. prometheus是一个开源的监控系统+时序数据库。
2. prometheus server 收集指标、查询指标
3. node exporter 导出系统指标，用一个兼容prometheus格式
4. Grafana:图形化的Dashboard builder 支持prometheus
5. 还有好多组件在prometheus 生态系统中，以上三个是一个好的开始

#### install prometheus
1. 用来存储指标、产生预警
2. docker安装，在prom组织下
3. 默认container内部

```
 配置文件:/etc/prometheus/prometheus.yml
 数据文件:/prometheus,用于存储指标数据
```
4. 修改默认配置的方式：传一个配置文件给docker

docker run -d -p 9090:9090 -v ~/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus -config.file=/etc/prometheus/prometheus.yml -storage.local.path=/prometheus -storage.local.memory-chunks=10000

## 安装 node exporter
1. 用于采集目标机器的数据
2. 需要配置一下，不然采集的是container数据

```
docker run -d -p 9100:9100 -v "/proc:/host/proc" -v "/sys:/host/sys" -v "/:/rootfs" --net="host" prom/node-exporter -collector.procfs /host/proc -collector.sysfs /host/proc -collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
```

sudo docker run \
    -d -p 9090:9090 \
    -v ~/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
