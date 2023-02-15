# MYSQL

## connect to mysql command

```bash
mysql -h <HOST> -u <USER> -p <DB_TO_USE_OPTIONAL_PARAMETER>
```

## common commands

1. Take a look at the tables in the database:
```sql
SHOW tables;
```

2. Review the employees table:
```sql
DESCRIBE <table_name>;
```

3. Review the dms_source table:
```sql
DESCRIBE <table_name>;
```

4. Review the full details of the first 10 rows of a table:
```sql
SELECT * FROM <table_name> LIMIT 10
```

5. Export results into a csv file 

```sql
SELECT * INTO OUTFILE 'table.csv'
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
FROM <TABLE>
```

6.- Export results into a tsv file
```bash
echo 'SELECT * FROM dms_source' | mysql -B -h <HOST> -u <USER> -p <TABLE> > report.tsv
```

7.- Use MysqlDump to Dump a Table
```bash
mysqldump -u <USER> -h <HOST> -p -t -T<OUTPUT_PATH> <DB> <TABLE> --fields-terminated-by=,
```
