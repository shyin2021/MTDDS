cd /home/postgres/tpcds-kit/tools/tmp_l
for i in *.dat; do
    table=${i/.dat/}
    echo "Loading $table..."
    sed 's/|$//' $i > /tmp/$i
    psql -h master -p 30001 -U tenant3 -d tenant3 -q -c "TRUNCATE $table"
    psql -h master -p 30001 -U tenant3 -d tenant3 -c "\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'"
done
