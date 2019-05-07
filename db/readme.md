# mysql 数据库没有分区异常
1. table has no partition for value from column_list; nested exception is java.sql.SQLException: Table has no partition for value from column_list
一般这种问题是由于数据库分区不存在，找一下 DBA。如果是根据时间进行的分区，那就是插入的时间不对，也就是说你的应用服务器的时间有问题。


# mysql 创建时间与更新时间设置
```sql
 CREATE TABLE `your_table` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增 ID',
  `appid` varchar(255) NOT NULL DEFAULT '' COMMENT '应用 ID 从10000开始',
  `appName` varchar(255) NOT NULL DEFAULT '' COMMENT '应用名称',
  `enable` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否起作用，0：不起作用，1：起作用',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `valid` tinyint(4) NOT NULL DEFAULT 1 COMMENT '用于标示该记录是否逻辑删除，0:已删除 1:正常有效',
  `createTime` datetime NOT NULL DEFAULT current_timestamp() COMMENT '插入时间',
  `updateTime` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='管理表';
```
## 修改分区
```sql
alter table xxxx add partition (partition p3 values less than(to_days('2019-06-01'))); 
```

## 删除分区
```sql
alter table xxx drop partition p3; 
```
## 删除分区数据
```sql
alter table xxxxxx  truncate partition p1,p2;  
alter table xxxxxx  truncate partition all; 
```
## 
```sql
alter table xxxxx reorganize partition p1,p3,p4 into (partition pm1 values less than(2006),  
partition pm2 values less than(2011));  
```alter  table xxxxxx analyze partition pm1/all;  
##
```sql
alter  table xxxxxx rebuild partition pm1/all; //相当于drop所有记录，然后再reinsert；可以解决磁盘碎片  
```
##
```sql
alter  table tt2 optimize partition pm1; //在大量delete表数据后，可以回收空间和碎片整理。但在5.5.30后支持。在5.5.30之前可以通过recreate+analyze来替代，如果用rebuild+analyze速度慢  
```
##
```sql
alter  table xxxxxx analyze partition pm1/all;  
alter  table xxxxxx check partition pm1/all;  
show create table employees2;  //查看分区表的定义  
show table status like 'employees2'\G;    //查看表时候是分区表 如“Create_options: partitioned”  
select * from information_schema.KEY_COLUMN_USAGE where table_name='employees2';   //查看索引  
SELECT * FROM information_schema.partitions WHERE table_name='employees2'   //查看分区表  
explain partitions select * from employees2 where separated < '1990-01-01' or separated > '2016-01-01';   //查看分区是否被select使用  
```
