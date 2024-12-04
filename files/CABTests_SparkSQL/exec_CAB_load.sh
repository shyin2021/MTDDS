output_dir=mtdds/CABTests_SparkSQL/output
cd $SPARK_HOME
sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse -f ~/mtdds/CABTests_SparkSQL/createTenants.sql
for i in {0..9}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_1.sql > $output_dir/create_tables.out
done
for i in {10..11}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_2.sql
done
for i in {12..13}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_3.sql
done
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant14 -f ~/mtdds/CABTests_SparkSQL/creation_5.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant15 -f ~/mtdds/CABTests_SparkSQL/creation_6.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant16 -f ~/mtdds/CABTests_SparkSQL/creation_8.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant17 -f ~/mtdds/CABTests_SparkSQL/creation_12.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant18 -f ~/mtdds/CABTests_SparkSQL/creation_18.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.sql.warehouse.dir=hdfs://gros-21:9000/usr/spark/spark-warehouse --database tenant19 -f ~/mtdds/CABTests_SparkSQL/creation_31.sql
sbin/stop-all.sh
