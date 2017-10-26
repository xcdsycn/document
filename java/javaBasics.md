# java 基础操作
## 线程安全的计数器
### AtomX类实现，这种实现会有存储空间浪费，一个是存储AtomX对象，一个是存储实际的值
```java
public class Record {
 private final AtomicLong version = new AtomicLong(0);

 public long update() {
   return version.incrementAndGet();
 }
}
```
### AtomXxxFieldUpdate实现，这种实现是基础静态类实现的方法，其实这个原则适用于所有情况，静态的类，就是单例的

```java
public class Record {
 private static final AtomicLongFieldUpdater<Record> VERSION =
      AtomicLongFieldUpdater.newUpdater(Record.class, "version");

 private volatile long version = 0;

 public long update() {
   return VERSION.incrementAndGet(this);
 }
}
```

