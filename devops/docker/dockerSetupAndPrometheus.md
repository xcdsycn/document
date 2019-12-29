
install docker has to method:
1. install on a exist centos 7
2. with a tool called docker machine

# method 1
## Prerequisites
1. 64-bit centos7
2. No-root user with sudo
## docker compose
1. fig 用yaml来编排docker containers和配置
2. 基于fig做了Docker Compose
3. 用来方便container的启动、停止等

## 安装步骤
### 1 安装docker
1. remove docker
yum list installed | grep docker

2. install docker
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7

### 2 安装Docker Compose

### 3. install docker compose & prometheus


sudo docker run \
    -d -p 9090:9090 \
    -v /usr/local/src/file/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
