# mysql 数据库没有分区异常
1. table has no partition for value from column_list; nested exception is java.sql.SQLException: Table has no partition for value from column_list
一般这种问题是由于数据库分区不存在，找一下 DBA。如果是根据时间进行的分区，那就是插入的时间不对，也就是说你的应用服务器的时间有问题。
