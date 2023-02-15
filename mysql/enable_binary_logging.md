# Enable the binary log file manually

## Locate the configuration file of MySQL Server my.cnf or mysql.cnf

As a rule, this file is located along the path:
```sh
/etc/mysql.cnf
```

or
```sh
/etc/my.cnf
```

If you cannot find it, please use the following command:
sudo find / -type f -name mysql.cnf

## Edit the configuration file of MySQL

Run:
```sh
sudo nano /etc/mysql.cnf
```

and add the following text to the end of the file:

```
[mysqld]  
server-id        = 1 
expire_logs_days = 10 
binlog_format    = row 
log_bin          = /var/log/mysql/mysql-bin
```

## Restart MySQL Server

sudo service mysql restart

## Confirming the Changes
After restarting the MySQL server, you can check the binary logging status again. Make sure the log_bin is ON and the binary log format is the format supported by the replication tools. For example, Oracle GoldenGate 11.2 and 12c only supports ROW format. 

```sql
mysql> select variable_value as "BINARY LOGGING STATUS (log_bin) :: " 
from information_schema.global_variables where variable_name='log_bin';
```

| BINARY LOGGING STATUS (log_bin) ::  |
|----------------------------------------|
| ON                                  |
```1 row in set (0.00 sec)```

---

```sql
mysql> select variable_value as "BINARY LOG FORMAT (binlog_format) :: " 
from information_schema.global_variables where variable_name='binlog_format';
```

| BINARY LOG FORMAT (binlog_format) ::  |
|----------------------------------------|
| ROW                                   |
```1 row in set (0.00 sec)```

---

Now, the MySQL database is be ready for replications. You can find the binary logs generated (How to find the directory storing MySQL binary log? ​). A simple check would be using the SQL command as follows:

```sql
mysql> show binary logs;
```

| Log_name   | File_size |
|------------|-----------|
| bin.000001 | 144       |
| bin.000002 | 239       |
| bin.000003 | 319       |
| bin.000004 | 107       |
```4 rows in set (0.00 sec)```

Please refer to  [What is the directory for storing MySQL binary logs?](http://jinyuwang.weebly.com/goldengate-for-mysql-blog/how-to-enable-binary-logging-for-mysql) if you can't find he binary log files. ​ 
