export CLASSPATH=$CLASSPATH:~/mtdds/src/core:~/mtdds/src/example
cd ~/mtdds/files
./step6ScriptsExecution.sh
cd ~/mtdds/files/step6Drivers_PostgresXL
export CLASSPATH=$CLASSPATH:~/mtdds/files/step6Drivers_PostgresXL:~/mtdds/files/postgresql-42.7.2.jar:~/mtdds/files/mybatis-3.5.14/mybatis-3.5.14.jar
for i in {1..15}; do
	pgxc_ctl start all
	pgxc_ctl monitor all
	java MTTestsDriver_SUT2 $i
	pgxc_ctl monitor all
	pgxc_ctl stop all
done
pgxc_ctl start all
pgxc_ctl monitor all
java MTTestsDriver_SUT2 1
pgxc_ctl monitor all
pgxc_ctl stop all
for i in {1..15}; do
	pgxc_ctl start all
	pgxc_ctl monitor all
	java MTTestsDriver_SUT1 $i
	pgxc_ctl monitor all
	pgxc_ctl stop all
done
