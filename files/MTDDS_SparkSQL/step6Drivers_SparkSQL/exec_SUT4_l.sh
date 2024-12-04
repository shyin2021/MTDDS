cd $SPARK_HOME
./sbin/stop-all.sh
./sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-121:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_databases.sql
# tenant5
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-121:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant5.sql

cd ~/mtdds/files_SparkSQL/step6Drivers_SparkSQL
export CLASSPATH=$CLASSPATH:~/mtdds/files_SparkSQL/step6Drivers_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH MTTestsDriver_SUT4_tenant5.java
for i in {10..20};
do
        cd $SPARK_HOME
        ./sbin/stop-all.sh
        ./sbin/start-all.sh
	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT4_tenant5 $i
done
./sbin/stop-all.sh
