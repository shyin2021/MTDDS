output_dir=mtdds/CABTests_SparkSQL/output
cd $SPARK_HOME
sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive -f ~/mtdds/CABTests_SparkSQL/createTenants.sql
for i in {0..9}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_1.sql
done
for i in {10..11}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_2.sql
done
for i in {12..13}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_3.sql
done
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant14 -f ~/mtdds/CABTests_SparkSQL/creation_5.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant15 -f ~/mtdds/CABTests_SparkSQL/creation_6.sql
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant16 -f ~/mtdds/CABTests_SparkSQL/creation_8.sql
sbin/stop-all.sh
