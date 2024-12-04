output_dir=mtdds/files_SparkSQL/step2Scripts_SparkSQL/output
cd $SPARK_HOME
./sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f mtdds/files_SparkSQL/step2Scripts_SparkSQL/create_m.sql > $output_dir/create_tables.out
./sbin/stop-all.sh
