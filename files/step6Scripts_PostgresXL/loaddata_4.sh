cd /home/postgres/tpcds-kit/tools/tmp_l
for i in *.dat; do
    table=${i/.dat/}
    echo "Loading $table..."
    sed 's/|$//' $i > /tmp/$i
    psql -h master -p 30001 -U tenant4 -d tenant4 -q -c "TRUNCATE $table"
    psql -h master -p 30001 -U tenant4 -d tenant4 -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
