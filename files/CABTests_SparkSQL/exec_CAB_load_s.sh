output_dir=mtdds/CABTests_SparkSQL/output
cd $SPARK_HOME
sbin/start-all.sh
bin/spark-sql --conf spark.sql.catalogImplementation=hive -f ~/mtdds/CABTests_SparkSQL/createTenants.sql
for i in {0..9}; do
    bin/spark-sql --conf spark.sql.catalogImplementation=hive --database tenant$i -f ~/mtdds/CABTests_SparkSQL/creation_1.sql
done
sbin/stop-all.sh
