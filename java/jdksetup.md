# Step 1 – Download Latest Java Archive
Download latest Java SE Development Kit 8 release from its official download page or use following commands to download from shell.

```bash
# cd /opt/
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz"
# tar xzf jdk-8u151-linux-x64.tar.gz
```
# Step 2 – Install Java 8 with Alternatives

```bash
# cd /opt/jdk1.8.0_151/
# alternatives --install /usr/bin/java java /opt/jdk1.8.0_151/bin/java 2
# alternatives --config java
```

At this point JAVA 8 has been successfully installed on your system. We also recommend to setup javac and jar commands path using alternatives

```bash
# alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_151/bin/jar 2
# alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_151/bin/javac 2
# alternatives --set jar /opt/jdk1.8.0_151/bin/jar
# alternatives --set javac /opt/jdk1.8.0_151/bin/javac

```
# Step 3 – Check Installed Java Version

```bash
# java -version
```

# Step 4 – Setup Java Environment Variables
set the following command to ~/.bash_profile


```bash
# export JAVA_HOME=/opt/jdk1.8.0_151
# export JRE_HOME=/opt/jdk1.8.0_151/jre
# export PATH=$PATH:/opt/jdk1.8.0_151/bin:/opt/jdk1.8.0_151/jre/bin
```
