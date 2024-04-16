cd /root/home/postgres/mtdds/tmp/l
for i in *.dat; do
    table=${i/.dat/}
    echo "Loading $table..."
    sed 's/|$//' $i > /tmp/$i
    psql -h 172.16.66.12 -p 20004 -U tenant5 -d tenant5 -q -c "TRUNCATE $table"
    psql -h 172.16.66.12 -p 20004 -U tenant5 -d tenant5 -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
