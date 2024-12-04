cd ~/mtdds/tpcds-kit/tools
echo "Generating the small dataset..."
./dsdgen -DIR /root/home/spark/mtdds/tmp/s -SCALE 1 -FORCE Y
echo "Generating the medium dataset..."
./dsdgen -DIR /root/home/spark/mtdds/tmp/m -SCALE 10 -FORCE Y
echo "Generating the large dataset..."
./dsdgen -DIR /root/home/spark/mtdds/tmp/l -SCALE 100 -FORCE Y
echo "Modifying the encoding of customer.dat..."
cd /root/home/spark/mtdds/tmp/s
iconv -fiso-8859-1 -t utf-8 customer.dat > customer_.dat
rm customer.dat
mv customer_.dat customer.dat
cd /root/home/spark/mtdds/tmp/m
iconv -fiso-8859-1 -t utf-8 customer.dat > customer_.dat
rm customer.dat
mv customer_.dat customer.dat
cd /root/home/spark/mtdds/tmp/l
iconv -fiso-8859-1 -t utf-8 customer.dat > customer_.dat
rm customer.dat
mv customer_.dat customer.dat
echo "Finished."
