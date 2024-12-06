export CLASSPATH=$CLASSPATH:~/mtdds/src/core:~/mtdds/src/example
cd $SPARK_HOME
./sbin/stop-all.sh
./sbin/start-all.sh
#cd ~/mtdds/files_SparkSQL
#./step6ScriptsExecution.sh
cd ~/mtdds/files_SparkSQL/step6Drivers_SparkSQL
export CLASSPATH=$CLASSPATH:~/mtdds/files_SparkSQL/step6Drivers_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH MTTestsDriver_SUT3.java
for i in {1..20};
do
        cd $SPARK_HOME
        ./sbin/stop-all.sh
        ./sbin/start-all.sh
	java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH MTTestsDriver_SUT3 $i
done
