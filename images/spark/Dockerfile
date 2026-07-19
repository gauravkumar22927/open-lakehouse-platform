FROM apache/hive:4.0.1 AS hive-client
FROM lakehouse/hive-metastore:1.0 AS hadoop-runtime

FROM apache/spark:4.0.1

USER root

COPY conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf

RUN mkdir -p /opt/spark/jars /opt/hive4/lib

# Spark 4 includes Hive 4 shims, but its built-in metastore client jars are
# Hive 2.3.10. Use Hive 4 client jars for compatibility with Hive Metastore 4.
COPY --from=hive-client /opt/hive/lib/ /opt/hive4/lib/
RUN rm -f /opt/hive4/lib/hadoop-*.jar

# PostgreSQL JDBC
RUN curl -fsSL \
https://jdbc.postgresql.org/download/postgresql-42.7.7.jar \
-o /opt/spark/jars/postgresql-42.7.7.jar

# Hadoop S3A and matching AWS SDK bundle from the same Hadoop 3.4.1 runtime
# used by Hive Metastore.
COPY --from=hadoop-runtime /opt/hadoop/share/hadoop/tools/lib/hadoop-aws-3.4.1.jar /opt/spark/jars/hadoop-aws-3.4.1.jar
COPY --from=hadoop-runtime /opt/hadoop/share/hadoop/tools/lib/bundle-2.24.6.jar /opt/spark/jars/aws-sdk-v2-bundle-2.24.6.jar

# Delta Lake
RUN curl -fsSL \
https://repo1.maven.org/maven2/io/delta/delta-spark_2.13/4.0.0/delta-spark_2.13-4.0.0.jar \
-o /opt/spark/jars/delta-spark_2.13-4.0.0.jar

RUN curl -fsSL \
https://repo1.maven.org/maven2/io/delta/delta-storage/4.0.0/delta-storage-4.0.0.jar \
-o /opt/spark/jars/delta-storage-4.0.0.jar

USER spark
