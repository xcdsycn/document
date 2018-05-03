# 系统终止的问题
## 1.先看一段代码
```java
public static void main(String[] args) throws InterruptedException {  
  
       Thread thread = new Thread(new Runnable() {  
           @Override  
           public void run() {  
               while (true) {  
                   try {  
                       Thread.sleep(3000);  
                       System.out.println("shutdown");  
                       System.exit(0);  
                   } catch (Exception e) {  
                   }  
               }  
           }  
       });  
       thread.start();  
         
       Runtime.getRuntime().addShutdownHook(new Thread() {  
           @Override  
           public void run() {  
               System.out.println("hook exit");  
               System.exit(0);  
           }  
       });  
         
```
这段代码是不会正常的退出的，原因是 shutdownHook 中如果调用 System.exit()会产生死锁，两个线程会相互等待释放资源。如果要强制终止，使用 Runtime.getRunTime().halt(0)。非理性的退出系统。
