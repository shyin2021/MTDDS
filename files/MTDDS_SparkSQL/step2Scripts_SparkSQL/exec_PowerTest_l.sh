cd ~/mtdds/files_SparkSQL/step2Scripts_SparkSQL
export CLASSPATH=$CLASSPATH:~/mtdds/files_SparkSQL/step2Scripts_SparkSQL:/root/home/spark/jars/*
javac -cp $CLASSPATH PowerTest_l.java
cd $SPARK_HOME
./sbin/stop-all.sh
./sbin/start-all.sh
java --add-exports java.base/sun.nio.ch=ALL-UNNAMED -cp $CLASSPATH PowerTest_l
