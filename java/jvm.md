# jvm 内存解析

## 先来一张图

![jvm mem](../imgs/jvm.png)

JVM内存结构主要有三大块：堆内存、方法区和栈。堆内存是JVM中最大的一块由年轻代和老年代组成，而年轻代内存又被分成三部分，Eden空间、From Survivor空间、To Survivor空间,默认情况下年轻代按照8:1:1的比例来分配；

方法区存储类信息、常量、静态变量等数据，是线程共享的区域，为与Java堆区分，方法区还有一个别名Non-Heap(非堆)；栈又分为java虚拟机栈和本地方法栈主要用于方法的执行。

## 再来一张图
![jvm args](../imgs/jvmArgs.png)

是不是感觉瞬间就什么都知道了？所以说千言万语不如一张图。

### 控制参数
-Xms设置堆的最小空间大小。

-Xmx设置堆的最大空间大小。

-XX:NewSize设置新生代最小空间大小。

-XX:MaxNewSize设置新生代最大空间大小。

-XX:PermSize设置永久代最小空间大小。

-XX:MaxPermSize设置永久代最大空间大小。

-Xss设置每个线程的堆栈大小。

没有直接设置老年代的参数，但是可以设置堆空间大小和新生代空间大小两个参数来间接控制。
老年代空间大小=堆空间大小-年轻代大空间大小
从更高的一个维度再次来看JVM和系统调用之间的关系
方法区和堆是所有线程共享的内存区域；而Java栈、本地方法栈和程序计数器是运行是线程私有的内存区域。

## 说明
但是，没有文字说明，也只是傻看。具体这图是什么意思，傻看也是看不明白的。自己写不出来。看了一篇文章，怕以后找不到了，索性拷贝过来，备用。

## 各区介绍
### Java堆（Heap）

对于大多数应用来说，Java堆（Java Heap）是Java虚拟机所管理的内存中最大的一块。Java堆是被所有线程共享的一块内存区域，在虚拟机启动时创建。此内存区域的唯一目的就是存放对象实例，几乎所有的对象实例都在这里分配内存。

Java堆是垃圾收集器管理的主要区域，因此很多时候也被称做“GC堆”。如果从内存回收的角度看，由于现在收集器基本都是采用的分代收集算法，所以Java堆中还可以细分为：新生代和老年代；再细致一点的有Eden空间、From Survivor空间、To Survivor空间等。

根据Java虚拟机规范的规定，Java堆可以处于物理上不连续的内存空间中，只要逻辑上是连续的即可，就像我们的磁盘空间一样。在实现时，既可以实现成固定大小的，也可以是可扩展的，不过当前主流的虚拟机都是按照可扩展来实现的（通过-Xmx和-Xms控制）。

如果在堆中没有内存完成实例分配，并且堆也无法再扩展时，将会抛出OutOfMemoryError异常。

### 方法区（Method Area）
方法区（Method Area）与Java堆一样，是各个线程共享的内存区域，它用于存储已被虚拟机加载的类信息、常量、静态变量、即时编译器编译后的代码等数据。虽然Java虚拟机规范把方法区描述为堆的一个逻辑部分，但是它却有一个别名叫做Non-Heap（非堆），目的应该是与Java堆区分开来。

对于习惯在HotSpot虚拟机上开发和部署程序的开发者来说，很多人愿意把方法区称为“永久代”（Permanent Generation），本质上两者并不等价，仅仅是因为HotSpot虚拟机的设计团队选择把GC分代收集扩展至方法区，或者说使用永久代来实现方法区而已。

Java虚拟机规范对这个区域的限制非常宽松，除了和Java堆一样不需要连续的内存和可以选择固定大小或者可扩展外，还可以选择不实现垃圾收集。相对而言，垃圾收集行为在这个区域是比较少出现的，但并非数据进入了方法区就如永久代的名字一样“永久”存在了。这个区域的内存回收目标主要是针对常量池的回收和对类型的卸载，一般来说这个区域的回收“成绩”比较难以令人满意，尤其是类型的卸载，条件相当苛刻，但是这部分区域的回收确实是有必要的。

根据Java虚拟机规范的规定，当方法区无法满足内存分配需求时，将抛出OutOfMemoryError异常。

### 程序计数器（Program Counter Register）
程序计数器（Program Counter Register）是一块较小的内存空间，它的作用可以看做是当前线程所执行的字节码的行号指示器。在虚拟机的概念模型里（仅是概念模型，各种虚拟机可能会通过一些更高效的方式去实现），字节码解释器工作时就是通过改变这个计数器的值来选取下一条需要执行的字节码指令，分支、循环、跳转、异常处理、线程恢复等基础功能都需要依赖这个计数器来完成。
由于Java虚拟机的多线程是通过线程轮流切换并分配处理器执行时间的方式来实现的，在任何一个确定的时刻，一个处理器（对于多核处理器来说是一个内核）只会执行一条线程中的指令。因此，为了线程切换后能恢复到正确的执行位置，每条线程都需要有一个独立的程序计数器，各条线程之间的计数器互不影响，独立存储，我们称这类内存区域为“线程私有”的内存。
如果线程正在执行的是一个Java方法，这个计数器记录的是正在执行的虚拟机字节码指令的地址；如果正在执行的是Natvie方法，这个计数器值则为空（Undefined）。

此内存区域是唯一一个在Java虚拟机规范中没有规定任何OutOfMemoryError情况的区域。

### JVM栈（JVM Stacks）
与程序计数器一样，Java虚拟机栈（Java Virtual Machine Stacks）也是线程私有的，它的生命周期与线程相同。虚拟机栈描述的是Java方法执行的内存模型：每个方法被执行的时候都会同时创建一个栈帧（Stack Frame）用于存储局部变量表、操作栈、动态链接、方法出口等信息。每一个方法被调用直至执行完成的过程，就对应着一个栈帧在虚拟机栈中从入栈到出栈的过程。

局部变量表存放了编译期可知的各种基本数据类型（boolean、byte、char、short、int、float、long、double）、对象引用（reference类型，它不等同于对象本身，根据不同的虚拟机实现，它可能是一个指向对象起始地址的引用指针，也可能指向一个代表对象的句柄或者其他与此对象相关的位置）和returnAddress类型（指向了一条字节码指令的地址）。

其中64位长度的long和double类型的数据会占用2个局部变量空间（Slot），其余的数据类型只占用1个。局部变量表所需的内存空间在编译期间完成分配，当进入一个方法时，这个方法需要在帧中分配多大的局部变量空间是完全确定的，在方法运行期间不会改变局部变量表的大小。

在Java虚拟机规范中，对这个区域规定了两种异常状况：如果线程请求的栈深度大于虚拟机所允许的深度，将抛出StackOverflowError异常；如果虚拟机栈可以动态扩展（当前大部分的Java虚拟机都可动态扩展，只不过Java虚拟机规范中也允许固定长度的虚拟机栈），当扩展时无法申请到足够的内存时会抛出OutOfMemoryError异常。


### 本地方法栈（Native Method Stacks）
本地方法栈（Native Method Stacks）与虚拟机栈所发挥的作用是非常相似的，其区别不过是虚拟机栈为虚拟机执行Java方法（也就是字节码）服务，而本地方法栈则是为虚拟机使用到的Native方法服务。虚拟机规范中对本地方法栈中的方法使用的语言、使用方式与数据结构并没有强制规定，因此具体的虚拟机可以自由实现它。甚至有的虚拟机（譬如Sun HotSpot虚拟机）直接就把本地方法栈和虚拟机栈合二为一。与虚拟机栈一样，本地方法栈区域也会抛出StackOverflowError和OutOfMemoryError异常。

# jvm 参数查看
## 要想看到JVM执行时使用在使用哪些参数以及其各参数默认值，可以使用这个命令
```shell
java -XX:+PrintFlagsFinal -version

如果这些参数还不够全，你可以打开几个开关：

java -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+PrintFlagsFinal -version

实例
java -Xms10g -Xmx10g -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -Xloggc:/var/log/myapp/gc.log -XX:+UseGCLogFileRotation -XX:GCLogFileSize=10M -XX:NumberOfGCLogFiles=20 -jar myapp.jar
```
# 环境问题
## mac下查看 jdk，java 安装 路径
```shell
/usr/libexec/java_home -V
```

## visualVM 监控

### 开启 JMX
如果需要监控本地的 java 程序，需要在本地的机器上开启，如果监控服务器，也需要在服务器上开启，这样远程本地都可以监控了。因为 jvm 默认是不开启JMX的。

#### 开启方式

```java
 java.rmi.server.hostname=ineedabargain.com // without this, on linux, jconsole will fail to connect
  com.sun.management.jmxremote.authenticate=false // default is true if not set
  com.sun.management.jmxremote.password.file=<password file location>   //2
  com.sun.management.jmxremote.ssl=false
  com.sun.management.jmxremote.port=<portNum>
```
password 只有在 authenticate=true 的时候才会有用，因为这时需要提供用户名密码访问。

Password file defines the password of each role/user. Only applicable if authenticate is set to true. What the actual role/user can do is defined in another file called access file. Default location/value is JRE_HOME/lib/management/jmxremote.password.

#### 例子
##### JMX Client Accesses JMX Agent without Authentication

```shell
java ⋯⋯ -Djava.rmi.server.hostname=ineedabargain.com -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=1234 ⋯⋯
```
##### JMX Client Accesses JMX Agent with Authentication
leave com.sun.management.jmxremote.authenticate=true, com.sun.management.jmxremote.password.file=<pwd file location>。
具体做法

```shell
su <user that runs java app>
cp /usr/java/default/jre/lib/management/jmxremote.password.template /home/tomcat/jmxremote.passwordcd ~
chmod 600 jmxremote.password
emacs jmxremote.password
```

密码文件内容
```shell
# specify actual password instead of the text password
monitorRole <password>
controlRole <password>
```
连接的时候使用 controlRole，因为它的权限大，可看的内容多些。

#### 运行有权限开启的命令
```sehll
java ⋯⋯ -Djava.rmi.server.hostname=ineedabargain.com -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=1234 -Dcom.sun.management.jmxremote.password.file=/home/tomcat/jmxremote.password ⋯⋯
```

### 运行 visualVM 执行监控就可以了
## [配置参数说明](http://blog.sokolenko.me/2014/11/javavm-options-production.html)

## [JVM参数之143](https://www.ibm.com/support/knowledgecenter/zh/SSYKE2_8.0.0/com.ibm.java.aix.80.doc/diag/understanding/mm_heapsizing_initial.html)

