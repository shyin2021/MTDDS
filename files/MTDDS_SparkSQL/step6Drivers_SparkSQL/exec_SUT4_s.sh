cd $SPARK_HOME
./sbin/stop-all.sh
./sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_databases.sql
# tenant2
#bin/spark-sql --conf spark.sql.catalogImplementation=hive -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant2.sql
# tenant4
bin/spark-sql --conf spark.sql.catalogImplementation=hive -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant4.sql

cd ~/mtdds/files_SparkSQL/step6Drivers_SparkSQL
export CLASSPATH=$CLASSPATH:~/mtdds/files_SparkSQL/step6Drivers_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH MTTestsDriver_SUT4_tenant2.java
javac -cp $CLASSPATH MTTestsDriver_SUT4_tenant4.java
for i in {14..18};
do
        cd $SPARK_HOME
#        ./sbin/stop-all.sh
#        ./sbin/start-all.sh
#	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT4_tenant2 $i
        ./sbin/stop-all.sh
        ./sbin/start-all.sh
	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT4_tenant4 $i
done
