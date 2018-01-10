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
## spring boot 启动外部配置文件，不读取默认的application.properties

spring.config.location=location_of_your_config_file.properties

## spring 动态刷新配置applicationContext，也就是xml配置文件

```java
    @RequestMapping(value="refreshXmlWebApplicationContext2016}")
    public void refresh(HttpServletRequest request){
         XmlWebApplicationContext context =
                 (XmlWebApplicationContext)WebApplicationContextUtils
                 .getWebApplicationContext(request.getServletContext());
         context.refresh();
    }
```
## 使用多个 PropertyPlaceholderConfigurer达到加载不同环境配置文件的目的
因为spring支持声明多个 propertyPlaceholderConfigurer，而先加载的 propertyPlaceholderConfigurer中的属性不会被后面的同名属性所覆盖，基于这个原理我们声明两个 propertyPlaceholderConfigurer，如下:

```xml
<bean id="propertyConfigurer1"
 class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
    <property name="order" value="1"/>
    <property name="ignoreResourceNotFound" value="true"/>
    <property name="ignoreUnresolvablePlaceholders" value="true" />
    <property name="location" value="file:${catalina.home}/conf/mysqlDS.properties"/>
</bean>
<bean id="propertyConfigurer2"
 class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
    <property name="order" value="2"/>
    <property name="ignoreUnresolvablePlaceholders" value="true" />
    <property name="location" value="classpath:mysqlDS.properties"/>
</bean>
```
### 说明 
  - 第一个配置加载tomcat目录conf下的 mysqlDS.properties，注意这里使用了file:，${catalina.home}只要tomcat启动它就会存在。
  - 第二个配置加载classpath下的 mysqlDS.properties，这个跟上面一样。
  - 其中order属性代表其加载的顺序,如果没有则按照在xml中的声明顺序。
  - ignoreUnresolvablePlaceholders是否忽略不可解析的Placeholder，这里必须设为true，否则在你的开发环境tomcat下没有放置 mysqlDS.properties就抛出异常了。

### 假设两个配置文件一模一样，它们的解析规则如下：
1. propertyConfigurer1加载配置文件后，它里面的属性并不会被后面的 propertyConfigurer2所覆盖，这时 propertyConfigurer2是失效的。
2. tomcat下的 mysqlDS.properties不存在时， propertyConfigurer1失效，这时 propertyConfigurer2将加载配置文件。
3. 多个 propertyConfigurer不会相互覆盖，但 如果同一个 propertyConfigurer中加载了多个配置文件，则后面的会覆盖前面先加载的的。
4. 这里指的是属性相同的情况，如果属性不同则不会有任何冲突都将被加载。
基于上面的原理，我们只需要在正式的tomcat的conf目录下放一个 mysqlDS.properties就能达到我们的目的了，即简单又方便。

## 实现自定义的 PropertyPlaceholderConfigurer
这里我采用了上面的第一种方式，第二种就不细讲了，简单的贴一下代码，一看也就能明白

```java
public class CustomPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
    public void setCustomPropFiles(Set<String> customPropFiles) {
        //这里假定配置文件都在tomcat的conf目录
        String tomcatHome = System.getProperty("catalina.home") + "/conf";
        String fileSeparator = System.getProperty("file.separator");
        Properties properties = new Properties();
        for (String customPropFile : customPropFiles) {
            // 如develop、test、release 这里根据实际需要来确定配置文件名称，可以通过环境变量等方式，结合实际情况
            String propName = "test";
            customPropFile = StringUtils.replace(customPropFile, "${propName}", propName);
            String file = tomcatHome + fileSeparator + customPropFile;
            try {
                Properties prop = new Properties();
                //实际应用中这里最好判断一下文件是否存在
                prop.load(new FileInputStream(new File(file)));
                properties.putAll(prop);
            } catch (Exception e) {
                logger.error("加载配置文件失败:" + file, e);
                throw new RuntimeException("加载配置文件失败");
            }
        }
        //关键方法,通过这个方法将自定义加载的properties文件加入spring中
        this.setProperties(properties);
    }
}
```
在xml配置文件中声明：

```xml
<bean id="customPropertyPlaceholderConfigurer" 
       class="com.dexcoder.spring.ext.CustomPropertyPlaceholderConfigurer">
        <property name="customPropFiles">
            <set>
                <value>${propName}_ds.properties</value>
<value>${propName}_mq.properties</value>
            </set>
        </property>
</bean>
```

这样也就达到我们加载自定义配置文件的目的了，要注意的是这个 customPropertyPlaceholderConfigurer声明尽量靠前，要在spring执行 mergeProperties方法之前。

spring实际上就是调用org.springframework.core.io.support.PropertiesLoaderSupport#mergeProperties来完成配置文件的合并的，源码如下：

```java
/**
 * Return a merged Properties instance containing both the
 * loaded properties and properties set on this FactoryBean.
 */
protected Properties mergeProperties() throws IOException {
    Properties result = new Properties();
    if (this.localOverride) {
        // Load properties from file upfront, to let local properties override.
        loadProperties(result);
    }
    if (this.localProperties != null) {
        for (Properties localProp : this.localProperties) {
            CollectionUtils.mergePropertiesIntoMap(localProp, result);
        }
    }
    if (!this.localOverride) {
        // Load properties from file afterwards, to let those properties override.
        loadProperties(result);
    }
    return result;
}
```
注意localOverride的值，为true的话同名的用户属性将覆盖spring系统加载的属性。

# log4j config path point 
spring方式加载，配置web.xml中：

Spring加载log4j.properties，它提供了一个Log4jConfigListener，本身就能通过web.xml配置从指定位置加载log4j配置文件和log4j的输出路径，要注意的是

Log4jConfigListener必须要在Spring的Listener之前。

web.xml
```xml
<!-- 设置由Sprng载入的Log4j配置文件位置 -->
<context-param>
<param-name>log4jConfigLocation</param-name>
<param-value>WEB-INF/classes/log4j.properties</param-value>
</context-param>

<!-- Spring刷新Log4j配置文件变动的间隔,单位为毫秒 -->
<context-param>
<param-name>log4jRefreshInterval</param-name>
<param-value>10000</param-value>
</context-param>

<listener>
<listener-class>org.springframework.web.util.Log4jConfigListener</listener-class>
</listener>
```
