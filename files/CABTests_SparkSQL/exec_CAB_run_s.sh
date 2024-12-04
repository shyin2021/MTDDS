export CLASSPATH=$CLASSPATH:~/mtdds/CABTests_SparkSQL/json-20240303.jar:~/mtdds/CABTests_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH SparkSQLPool_s.java CABDriver_SUT4_s.java
for i in {0..16};
do 
    cd $SPARK_HOME
    ./sbin/stop-all.sh
    ./sbin/start-all.sh
    java -cp $CLASSPATH CABDriver_SUT4_s $i
    ./sbin/stop-all.sh
done
