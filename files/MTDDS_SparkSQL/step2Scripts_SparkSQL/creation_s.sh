output_dir=mtdds/files_SparkSQL/step2Scripts_SparkSQL/output
cd $SPARK_HOME
./sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive -f mtdds/files_SparkSQL/step2Scripts_SparkSQL/create_s.sql > $output_dir/create_tables.out
./sbin/stop-all.sh
