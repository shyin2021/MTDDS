cd /root/home/postgres/mtdds/tmp/l
for i in *.dat; do
	table=${i/.dat/}
	echo "Loading $table..."
	sed 's/|$//' $i > /tmp/$i
	psql -h 172.16.66.12 -p 20004 -d mtdds_power_l -q -c "TRUNCATE $table"
	psql -h 172.16.66.12 -p 20004 -d mtdds_power_l -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
psql -h 172.16.66.12 -p 20004 -d mtdds_power_l -f /root/home/postgres/mtdds/files/step2Scripts_PostgresXL/tpcds_ri.sql
psql -h 172.16.66.12 -p 20004 -d mtdds_power_l -f /root/home/postgres/mtdds/files/step2Scripts_PostgresXL/create_index_catalog.sql
psql -h 172.16.66.12 -p 20004 -d mtdds_power_l -c "analyze"

