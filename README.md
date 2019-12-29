# document
Here is my daily study documents place.It will be classified with GIT,JENKINS,MicroSevice etc.

## idea GC overhead limit exceeded,maven 视图 不显示 dependency
偶然发现，看到 pom.xml 文件中，```<project>```标签显示红色的提示，一查，原来是 maven 的内存设置的太小，解决的办法，就是到系统设置，找到 maven 的 importSettings，然后调大内存限制，[具体的办法参考](http://blog.csdn.net/xktxoo/article/details/78670234)

## APP
[如何使用 charles 用来抓包](app/charles.md)

## 软件架构
[软件架构理论](arch/theory.md)

## 数据库
[数据库技巧](db/readme.md)

## GIT
[常用 GIT 命令](git/commonCommand.md)

[GIT Sub module 用法](git/git_submodule.md)

[GIT 提交次数组统计](git/stasticTimesByCommitorOfRepository.md)

[初台化 GIT 库](git/初始化GIT库.md)

[推本地分支到远程](git/推本地分支到远程.md)

[Git hooks](git/githooks.md)

[Git 版本控制](git/gitVersionControll.md)

## java
[java 基本问题](java/foundation.md)

[log4j 配置文件相关问题](java/log4jConfig.md)

[jvm 相关知识](java/jvm.md)

[jdk安装设置](java/jdksetup.md)

[关闭 jvm -- system.exit()](java/systemexit.md)

[tomcat无法启动](tomcatError.md)

[性能问题定位](java/performance.md)

[单例模式中的延期加载](JavaSingletonClassCreateThreadSafe.md)

## microservice
[微服务设计](microservice/readme.md)


## shell
[查看内存使用情况](shell/linuxmem.md)

[生成RSA](shell/gen-rsa.sh)

## spring framework
[spring 属性文件加载顺序](springframework/readme.md)

[JSON验证](springframework/validator.md)

## DevOps
[dock & prometheus](/devops/docker/dockerSetupAndPrometheus.md)
