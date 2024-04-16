1. The script tpcds_ri.sql should be run after the creatTables_tenantX for each tenant.
2. The scripts alter_table_rep.sql and create_index_catalog.sql and the command "ANALYZE" should be run after the loaddata_X for each tenant.

To resume, the scripts should be run in the following order:
- createTenants.sql by the database administrator;
- createTables_tenantX.sql by the tenant X;
- tpcds_ri.sql by the tenant X
- loaddata_1.sh
- alter_table_rep.sql by the tenant X
- create_index_catalog.sql by the tenant X
- ANALYZE by the tenant X