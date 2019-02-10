FROM volantis/python:3.7

# Install Java
ARG ZULU_ARCH=zulu8.36.0.1-ca-jdk8.0.202-linux_x64
ARG JVM_DIR=/usr/local/jvm
ENV JAVA_HOME=${JVM_DIR}/jdk
RUN curl -skSLO https://cdn.azul.com/zulu/bin/${ZULU_ARCH}.tar.gz && \
    mkdir -p ${JVM_DIR} && \
    tar -xzf ${ZULU_ARCH}.tar.gz -C ${JVM_DIR} && \
    rm -f ${ZULU_ARCH}.tar.gz && \
    ln -sf ${JVM_DIR}/${ZULU_ARCH} ${JAVA_HOME}
ENV PATH=${JAVA_HOME}/bin:${PATH}

# Install Hadoop
ARG HADOOP_VERSION=2.6.5
ENV HADOOP_HOME=/usr/local/hadoop
RUN curl -skSL -O https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local && \
    rm -f hadoop-${HADOOP_VERSION}.tar.gz && \
    ln -sf /usr/local/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    chown -R ${DEFAULT_USER}:${DEFAULT_USER} ${HADOOP_HOME}
ENV HADOOP_CONF_DIR=/etc/hadoop/conf

# Install Spark
ARG SPARK_VERSION=2.3.2
ARG SPARK_HADOOP=without-hadoop
ENV SPARK_HOME=/usr/local/spark
RUN curl -skSL -O https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${SPARK_HADOOP}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-${SPARK_HADOOP}.tgz -C /usr/local && \
    rm -f spark-${SPARK_VERSION}-bin-${SPARK_HADOOP}.tgz && \
    ln -sf /usr/local/spark-${SPARK_VERSION}-bin-${SPARK_HADOOP} ${SPARK_HOME} && \
    chown -R ${DEFAULT_USER}:${DEFAULT_USER} ${SPARK_HOME} && \
    pip install -e ${SPARK_HOME}/python
ENV SPARK_DIST_CLASSPATH=${HADOOP_CONF_DIR}:${HADOOP_HOME}/share/hadoop/common/lib/*:${HADOOP_HOME}/share/hadoop/common/*:${HADOOP_HOME}/share/hadoop/hdfs:${HADOOP_HOME}/share/hadoop/hdfs/lib/*:${HADOOP_HOME}/share/hadoop/hdfs/*:${HADOOP_HOME}/share/hadoop/yarn/lib/*:${HADOOP_HOME}/share/hadoop/yarn/*:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*:${HADOOP_HOME}/share/hadoop/mapreduce/*

# Install packages specified in requirements.txt
ADD ./requirements.txt /usr/local/
RUN pip install -q -r /usr/local/requirements.txt

VOLUME ${HADOOP_CONF_DIR}

# vim:set ft=dockerfile sw=4 ts=4:
