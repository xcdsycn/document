# 单例模式中的延尽加载，可以保证创建的实例是线程安全的

```java
public class Singleton    
{    
    private static class SingletonHolder    
    {    
        public final static Singleton instance = new Singleton();    
    }    
   
    public static Singleton getInstance()    
    {    
        return SingletonHolder.instance;    
    }    
}
```
内部类的初始化是延迟的，外部类初始化时不会初始化内部类，只有在使用的时候才会初始化内部类。而Java语言规范规定，对于每一个类或接口C，都有一个唯一的初始化锁LC与之对应。也就是说，SingletonHolder在各个线程初始化的时候是同步执行的，且全权由JVM承包了。

Initialization On Demand Holder idiom的实现探讨中分析了单例的几种描述符（private static final / public static final / static final）之间的合理性，其推荐使用最后一种描述符方式更为合理。

创建一个对象的过程，如下

```java
memory = allocate();   //1：分配对象的内存空间
ctorInstance(memory);  //2：初始化对象
instance = memory;     //3：设置instance指向刚分配的内存地址
```
在一些编译器中会对代码进行优化而对语句进行重排序，这很常见，对于上面的三行伪代码，2和3可能会被重排，结果如下:

```java
memory = allocate();   //1：分配对象的内存空间
instance = memory;     //3：设置instance指向刚分配的内存地址
                       //注意，此时对象还没有被初始化！
ctorInstance(memory);  //2：初始化对象
```
只要是执行的步骤被拆分了，那么就可以引起多线程的并发问题。
