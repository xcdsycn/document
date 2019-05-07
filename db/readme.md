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
