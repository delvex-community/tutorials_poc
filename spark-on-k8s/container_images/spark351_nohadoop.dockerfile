FROM oraclelinux:8.7 AS builder
LABEL name="ashutoshh"
LABEL email="ashutoshh@linux.com"
# Installing jdk 17 
ENV jdk_version=17
ENV spark_version=3.5.1
ENV SPARK_HOME=/opt/spark
RUN yum install java-${jdk_version}-openjdk  java-${jdk_version}-openjdk-devel wget -y
WORKDIR ${SPARK_HOME}
RUN wget -O apache-spark.tgz  https://dlcdn.apache.org/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop3.tgz \
&& tar -xvzf apache-spark.tgz --strip-components=1 \
&& rm -rf apache-spark.tgz 

FROM builder AS apache-spark
WORKDIR /opt/spark
ENV SPARK_MASTER_PORT=7077 \
SPARK_MASTER_WEBUI_PORT=8080 \
SPARK_LOG_DIR=/opt/spark/logs \
SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out \
SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out \
SPARK_WORKER_WEBUI_PORT=8080 \
SPARK_WORKER_PORT=7000 \
SPARK_MASTER="spark://localhost:7077" \
SPARK_WORKLOAD="master"

EXPOSE 8080 7077 6066 
RUN mkdir -p $SPARK_LOG_DIR && \
touch $SPARK_MASTER_LOG && \
touch $SPARK_WORKER_LOG && \
ln -sf /dev/stdout $SPARK_MASTER_LOG && \
ln -sf /dev/stdout $SPARK_WORKER_LOG

COPY start-spark.sh /opt/ 
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/opt/start-spark.sh" ]
