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
