output_dir=mtdds/CABTests_SparkSQL/output
cd $SPARK_HOME
sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/CABTests_SparkSQL/createTenants.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant10 -f ~/mtdds/CABTests_SparkSQL/creation_2.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant11 -f ~/mtdds/CABTests_SparkSQL/creation_2.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant12 -f ~/mtdds/CABTests_SparkSQL/creation_3.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant13 -f ~/mtdds/CABTests_SparkSQL/creation_3.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant14 -f ~/mtdds/CABTests_SparkSQL/creation_5.sql
sbin/stop-all.sh
