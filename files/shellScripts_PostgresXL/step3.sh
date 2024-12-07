echo "====== Step 3 - Multi-tenant query workload generation ======"
cd /root/home/postgres/mtdds/src/core/
java TenantsGenerator 6 ~/mtdds/files/6tenants.csv
echo "6 tenants are generated."
java TenantQueriesGenerator ~/mtdds/files/6tenants.csv ~/mtdds/files/6tenantsQueries
echo "Queries for the 6 tenants are generated."
cd ~/mtdds/src/example/
java splitQueries ~/mtdds/files/step1QueriesWithExplain/l/query_0_l_pgxl.sql ~/mtdds/files/step3IndividualQueries/l
java splitQueries ~/mtdds/files/step1QueriesWithExplain/m/query_0_m_pgxl.sql ~/mtdds/files/step3IndividualQueries/m
java splitQueries ~/mtdds/files/step1QueriesWithExplain/s/query_0_s_pgxl.sql ~/mtdds/files/step3IndividualQueries/s
echo "Individual queries are extracted into separate files."
