# Hive Metastore Runtime

Custom standalone Hive Metastore image backed by PostgreSQL.

## Purpose

The stock `apache/hive:4.0.1` image can carry a Hadoop runtime that does not
match Spark 4.0.1's Hadoop 3.4.1 APIs. This image installs Hadoop 3.4.1 and
uses the matching S3A dependency set from the Hadoop distribution.

That avoids runtime errors such as:

```text
NoClassDefFoundError: org/apache/hadoop/fs/BulkDelete
```

## Runtime

- Hive Metastore: 4.0.1
- Hadoop: 3.4.1
- PostgreSQL JDBC: 42.7.7
- Thrift port: 9083

## State

The container is stateless. Persistent metastore data lives in PostgreSQL.
