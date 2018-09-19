# 类的延迟初始化
## 1 静态内部类
```java
public class InstanceFactory {
    private static class InstanceHolder {
        public static Instance instance = new Instance();
    }

    public static Instance getInstance() {
        return InstanceHolder.instance ;  //这里将导致InstanceHolder类被初始化
    }
}
```

## 2 volatile 关键字，禁用重排，双重检查锁
```java
public class SafeDoubleCheckedLocking {
    private volatile static Instance instance;

    public static Instance getInstance() {
        if (instance == null) {
            synchronized (SafeDoubleCheckedLocking.class) {
                if (instance == null)
                    instance = new Instance();//instance为volatile，现在没问题了
            }
        }
        return instance;
    }
}
```
