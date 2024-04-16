echo "====== Step 4 - Multi-tenant query workload tests ======"
cd ~/mtdds/src/example/
java MTTestsScriptWriter 1 10 1 4 8 ~/mtdds/files/6tenants.csv ~/mtdds/files/step4SourceScript ~/mtdds/files/step4cripts_PostgresXL
cd ~/mtdds/files/step4Scripts_PostgresXL
chmod +x loaddata_1.sh
chmod +x loaddata_2.sh
chmod +x loaddata_3.sh
chmod +x loaddata_4.sh
chmod +x loaddata_5.sh
chmod +x loaddata_6.sh
echo "Multi-tenant databases creation and data load scripts are generated."
