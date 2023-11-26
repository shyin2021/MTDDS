cd /home/postgres/tpcds-kit/tools/tmp_s
for i in *.dat; do
	table=${i/.dat/}
	echo "Loading $table..."
	sed 's/|$//' $i > /tmp/$i
	psql -h master -p 30001 -U mtdds -d mtdds_power_s -q -c "TRUNCATE $table"
	psql -h master -p 30001 -U mtdds -d mtdds_power_s -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
cd /home/postgres/mtdds
