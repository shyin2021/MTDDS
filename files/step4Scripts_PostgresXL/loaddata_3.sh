cd /root/home/postgres/mtdds/tmp/m
for i in *.dat; do
    table=${i/.dat/}
    echo "Loading $table..."
    sed 's/|$//' $i > /tmp/$i
    psql -h 172.16.66.12 -p 20004 -U tenant3 -d tenant3 -q -c "TRUNCATE $table"
    psql -h 172.16.66.12 -p 20004 -U tenant3 -d tenant3 -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
