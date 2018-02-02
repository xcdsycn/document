# document
Here is my daily study documents place.It will be classified with GIT,JENKINS,MicroSevice etc.

## idea GC overhead limit exceeded,maven 视图 不显示 dependency
偶然发现，看到 pom.xml 文件中，```<project>```标签显示红色的提示，一查，原来是 maven 的内存设置的太小，解决的办法，就是到系统设置，找到 maven 的 importSettings，然后调大内存限制，[具体的办法参考](http://blog.csdn.net/xktxoo/article/details/78670234)

