FROM apache/hive:4.0.1

USER root

# ------------------------------------------------------------------------------
# Install utilities
# ------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl procps tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# PostgreSQL JDBC Driver
# ------------------------------------------------------------------------------
RUN wget -q https://jdbc.postgresql.org/download/postgresql-42.7.7.jar \
    -O /opt/hive/lib/postgresql-42.7.7.jar

# ------------------------------------------------------------------------------
# Install Hadoop 3.4.1
# ------------------------------------------------------------------------------
RUN if ! wget --progress=dot:giga --tries=5 --timeout=30 \
      https://dlcdn.apache.org/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz; then \
      wget --progress=dot:giga --tries=5 --timeout=30 \
        https://archive.apache.org/dist/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz; \
    fi && \
    tar -xzf hadoop-3.4.1.tar.gz && \
    rm hadoop-3.4.1.tar.gz && \
    rm -rf /opt/hadoop && \
    mv hadoop-3.4.1 /opt/hadoop && \
    rm -f /opt/hive/lib/hadoop-*.jar

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV HADOOP_OPTIONAL_TOOLS=hadoop-aws
ENV HADOOP_CLASSPATH=/opt/hadoop/share/hadoop/tools/lib/*
ENV PATH=$PATH:/opt/hadoop/bin

# ------------------------------------------------------------------------------
# Hadoop AWS + AWS SDK v2
# ------------------------------------------------------------------------------
# The Hadoop binary distribution already includes hadoop-aws and its matching
# AWS SDK dependencies under share/hadoop/tools/lib. Reuse those jars so Hive
# does not mix Hadoop 3.4.1 S3A classes with an older Hadoop runtime.
RUN test -f /opt/hadoop/share/hadoop/tools/lib/hadoop-aws-3.4.1.jar && \
    test -n "$(find /opt/hadoop/share/hadoop/tools/lib -name 'bundle-*.jar' -o -name 'aws-java-sdk-bundle-*.jar' | head -n 1)"

# ------------------------------------------------------------------------------
# Hive Configuration
# ------------------------------------------------------------------------------
COPY hive-site.xml /opt/hive/conf/hive-site.xml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9083

ENTRYPOINT ["/entrypoint.sh"]
