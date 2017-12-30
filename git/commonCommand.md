# change remote git repository
- 1.one day your leader tell you, your git repository is changed to xxxx.git, and how you can change you local repository address?

Just use the command followd:

```bash
 git remote set-url origin yourNewRepositoryAddress
```
- 2.update one file from one branch

```bash
 git checkout branchname filename
 git checkout breanchA HFFrame/Global/Global_macro.h
``` 
## deploy jar to nexus

```bash
mvn clean deploy -X -Dmaven.test.skip=true
```
defualt is to release,if you want deploy SNAPSHOT version,please do like this:

```xml
<groupId>cc.mzone</groupId>
<artifactId>m1</artifactId>
<version>0.1-SNAPSHOT</version>
<packaging>jar</packaging>
```
# 拉远程分支到本地
git checkout origin/remoteName -b localName
