echo "Creating Spark history server"
hdfs dfs -mkdir -p /user/spark/applicationHistory
hdfs dfs -chmod -R 777 /user/spark

echo "Starting Spark history server"
start-history-server.sh

