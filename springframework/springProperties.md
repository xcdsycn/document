# spring 属性文件加载顺序
## 设定加载顺序，数字大的优先加载

```xml
<context:property-placeholder location="classpath*:/context2.properties" order="0"/>
<context:property-placeholder location="classpath*:/context.properties" order="100"/>
```
context2.properties将覆盖context.properties中的值。

## 覆盖其它properties
<context:property-override location="classpath:override.properties"/>

## 参考
http://static.springsource.org/spring/docs/3.1.x/spring-framework-reference/htmlsingle/spring-framework-reference.html#beans-factory-overrideconfigurer
