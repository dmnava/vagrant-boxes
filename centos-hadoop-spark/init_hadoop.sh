# allow ssh with no password
if [ ! -f ~/.ssh/id_rsa ]
then 
   echo "Creating RSA key and authorizing it to allow passless ssh"
   ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

   cat /vagrant/files/ssh_config >> ~/.ssh/config

   chmod 0600 ~/.ssh/authorized_keys ~/.ssh/config
fi

echo "Formatting HDFS"
hdfs namenode -format

echo "Starting HDFS"
/opt/hadoop/sbin/start-dfs.sh 

echo "Creating user home directory in HDFS"
hdfs dfs -mkdir -p /user/root
hdfs dfs -mkdir -p /user/vagrant
hdfs dfs -chown vagrant /user/vagrant

echo "Creating temp directories in HDFS"
hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod -R 777 /tmp

hdfs dfs -mkdir -p /var
hdfs dfs -chmod -R 777 /var

echo "Starting YARN"
/opt/hadoop/sbin/start-yarn.sh


echo "Starting history server"
/opt/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR
