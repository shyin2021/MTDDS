cd /root/home/postgres/mtdds/tmp/s
for i in *.dat; do
    table=${i/.dat/}
    echo "Loading $table..."
    sed 's/|$//' $i > /tmp/$i
    psql -h 172.16.66.12 -p 20004 -U tenant2 -d tenant2 -q -c "TRUNCATE $table"
    psql -h 172.16.66.12 -p 20004 -U tenant2 -d tenant2 -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
