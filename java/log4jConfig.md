# log4j按时间切分日志文件

|时间段 | 格式 | 原始日志 | 格式日志|
| :---- | :---- |:---- |:---- |
|按月|'.'yyyy-MM |/foo/bar.log |/foo/bar.log.2002-05|
|按周 |'.'yyyy-ww |/foo/bar.log |/foo/bar.log.2002-23|
|按天 |'.'yyyy-MM-dd| /foo/bar.log |/foo/bar.log.2002-03-08 default|
|半天 |'.'yyyy-MM-dd-a| /foo/bar.log |/foo/bar.log.2002-03-09-AM|
|按时 |'.'yyyy-MM-dd-HH |/foo/bar.log |/foo/bar.log.2002-03-09-10|
|按分 |'.'yyyy-MM-dd-HH-mm |/foo/bar.log |/foo/bar.log.2001-03-09-10-22|

# 可以定制外部加载配置文件

```java
            /*
             * BasicConfigurator replaced with PropertyConfigurator. log4j filePath
             */
            PropertyConfigurator.configure(configFilePath + "/log4j.properties");
```
