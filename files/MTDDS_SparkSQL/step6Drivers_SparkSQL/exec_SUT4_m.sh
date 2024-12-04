cd $SPARK_HOME
./sbin/stop-all.sh
./sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-121:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_databases.sql
# tenant1
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-121:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant1.sql
# tenant3
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-121:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant3.sql
# tenant6
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-121:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant6.sql

cd ~/mtdds/files_SparkSQL/step6Drivers_SparkSQL
export CLASSPATH=$CLASSPATH:~/mtdds/files_SparkSQL/step6Drivers_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH MTTestsDriver_SUT4_tenant1.java
javac -cp $CLASSPATH MTTestsDriver_SUT4_tenant3.java
javac -cp $CLASSPATH MTTestsDriver_SUT4_tenant6.java
for i in {10..20};
do
        cd $SPARK_HOME
        ./sbin/stop-all.sh
        ./sbin/start-all.sh
	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT4_tenant1 $i
        ./sbin/stop-all.sh
        ./sbin/start-all.sh
	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT4_tenant3 $i
        ./sbin/stop-all.sh
        ./sbin/start-all.sh
	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT4_tenant6 $i
done
