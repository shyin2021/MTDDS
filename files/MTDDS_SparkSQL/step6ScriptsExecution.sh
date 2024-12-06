cd $SPARK_HOME
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_databases.sql
# tenant1
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant1.sql
# tenant2
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant2.sql
# tenant3
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant3.sql
# tenant
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant4.sql
# tenant5
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant5.sql
# tenant6
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/files_SparkSQL/step6Scripts_SparkSQL/create_tables_tenant6.sql
