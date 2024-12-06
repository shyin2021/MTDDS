export CLASSPATH=$CLASSPATH:~/mtdds/CABTests_SparkSQL/json-20240303.jar:~/mtdds/CABTests_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH SparkSQLPool.java CABDriver_SUT4_m.java
for i in {10..14};
do 
    cd $SPARK_HOME
    ./sbin/stop-all.sh
    ./sbin/start-all.sh
    java -cp $CLASSPATH CABDriver_SUT4_m $i
done
./sbin/stop-all.sh
