HADOOP_VERSION=hadoop-2.9.0
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz

# Install JDK 8
yum install -y java-1.8.0-openjdk

cp /vagrant/files/hosts /etc/hosts

# Download wget
yum install -y wget

echo "Downloading Hadoop from ${HADOOP_MIRROR_DOWNLOAD}"
wget --quiet -O /tmp/hadoop.tgz ${HADOOP_MIRROR_DOWNLOAD}

echo "Downloaded successfully"

tar xf /tmp/hadoop.tgz -C /opt/
chown -R vagrant:vagrant /opt/${HADOOP_VERSION}
ln -s /opt/${HADOOP_VERSION} /opt/hadoop

echo "Creating Hadoop directories"
[ -d /data/hadoop ] && rm -rf /data/hadoop
su - vagrant -c "mkdir -p /data/hadoop/dfs/name /data/hadoop/dfs/data /data/hadoop/mr-history/tmp /data/hadoop/mr-history/done" 

echo "Copying configuration"
cp /vagrant/files/config/hadoop/* /opt/hadoop/etc/hadoop
chown -R vagrant:vagrant /opt/hadoop

# environment variables
cp /vagrant/files/env/hadoop.sh /etc/profile.d/
