# Install JDK 8
yum install -y java-1.8.0-openjdk

# Create kafka user and group
groupadd kafka
useradd kafka -g kafka

# Download Kafka
yum install -y wget
wget --quiet -O /opt/kafka.tgz http://apache.rediris.es/kafka/0.10.1.1/kafka_2.11-0.10.1.1.tgz
tar xf /opt/kafka.tgz -C /opt/
chown -R kafka:kafka /opt/kafka_2.11*
ln -s /opt/kafka_2.11* /opt/kafka

# Data directories are created
mkdir -p /data/zookeeper /data/kafka
chown kafka:kafka /data/* 

cp /vagrant/files/config/* /opt/kafka/config

# Setup as a service and start
cp /vagrant/files/systemd/*.service /etc/systemd/system
systemctl daemon-reload

echo "Starting zookeeper"
systemctl start zookeeper
echo "Starting kafka"
systemctl start kafka

systemctl enable zookeeper
systemctl enable kafka
