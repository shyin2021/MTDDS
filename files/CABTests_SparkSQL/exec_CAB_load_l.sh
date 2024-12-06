output_dir=mtdds/CABTests_SparkSQL/output
cd $SPARK_HOME
sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/CABTests_SparkSQL/createTenants.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant15 -f ~/mtdds/CABTests_SparkSQL/creation_6.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant16 -f ~/mtdds/CABTests_SparkSQL/creation_8.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant17 -f ~/mtdds/CABTests_SparkSQL/creation_12.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant18 -f ~/mtdds/CABTests_SparkSQL/creation_18.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant19 -f ~/mtdds/CABTests_SparkSQL/creation_31.sql
sbin/stop-all.sh
