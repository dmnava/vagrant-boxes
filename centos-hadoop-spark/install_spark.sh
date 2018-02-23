SPARK_VERSION=spark-2.2.1
SPARK_HADOOP_VERSION=${SPARK_VERSION}-bin-hadoop2.7
SPARK_MIRROR_DOWNLOAD=http://archive.apache.org/dist/spark/${SPARK_VERSION}/${SPARK_HADOOP_VERSION}.tgz

echo "Downloading Spark from ${SPARK_MIRROR_DOWNLOAD}"
wget --quiet -O /tmp/spark.tgz ${SPARK_MIRROR_DOWNLOAD}

echo "Downloaded successfully"

tar xf /tmp/spark.tgz -C /opt/
chown -R vagrant:vagrant /opt/${SPARK_HADOOP_VERSION}
ln -s /opt/${SPARK_HADOOP_VERSION} /opt/spark

echo "Copying configuration"
cp /vagrant/files/config/spark/* /opt/spark/conf
chown -R vagrant:vagrant /opt/spark

# environment variables
cp /vagrant/files/env/spark.sh /etc/profile.d/
