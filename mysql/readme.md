## connect to mysql command

```sh
mysql -h <HOST> -u <USER> -p <DB_TO_USE_OPTIONAL_PARAMETER>
```

1. Take a look at the tables in the database:
```SHOW tables;```

2. Review the employees table:
```DESCRIBE <table_name>;```

3. Review the dms_source table:
```DESCRIBE <table_name>;```

4. Review the full details of the first 10 rows of a table:
```SELECT * FROM <table_name> LIMIT 10```
