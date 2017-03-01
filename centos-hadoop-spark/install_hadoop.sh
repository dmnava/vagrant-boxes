HADOOP_VERSION=hadoop-2.7.3
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz

# Install JDK 8
yum install -y java-1.8.0-openjdk

# Create kafka user and group
groupadd hadoop
useradd hadoop -g hadoop

# Download wget
yum install -y wget

echo "Dowloading Hadoop from ${HADOOP_MIRROR_DOWNLOAD}"
wget --quiet -O /opt/hadoop.tgz ${HADOOP_MIRROR_DOWNLOAD}
echo "Dowloaded successfully"

tar xf /opt/hadoop.tgz -C /opt/
chown -R hadoop:hadoop /opt/${HADOOP_VERSION}
ln -s /opt/${HADOOP_VERSION} /opt/hadoop

echo "Creating Hadoop directories"
mkdir -p /data/hadoop/dfs/name /data/hadoop/dfs/data /data/hadoop/mr-history/tmp /data/hadoop/mr-history/done

echo "Copying configuration"
cp /vagrant/files/config/* /opt/hadoop/etc/hadoop

# environment variables
cp /vagrant/files/hadoop.sh /etc/profile.d/
. /etc/profile.d/hadoop.sh

echo "Formatting HDFS"
hdfs namenode -format

echo "Starting HDFS"
/vagrant/files/start-hadoop.sh

echo "Creating user home directory in HDFS"
hdfs dfs -mkdir -p /user/root
hdfs dfs -mkdir -p /user/vagrant
hdfs dfs -chown vagrant /user/vagrant

echo "Creating temp directories in HDFS"
hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod -R 777 /tmp

hdfs dfs -mkdir -p /var
hdfs dfs -chmod -R 777 /var

# Setup as a service and start
#cp /vagrant/files/systemd/*.service /etc/systemd/system
#systemctl daemon-reload

#echo "Starting zookeeper"
#systemctl start zookeeper

#systemctl enable zookeeper
