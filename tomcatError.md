# Caused by: java.lang.NoSuchMethodError: javax.servlet.ServletContext.getVirtualServerName()Ljava/lang/String;
1. 一般都是因为，如果是外部tomcat启动，一般就是有内嵌的tomcat，在pom依赖中搜索tomcat；
2. 再就是Jar包冲突，看看Servlet依赖是否是有compile的，一般都应该是provided；
