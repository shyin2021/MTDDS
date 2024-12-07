cd ~/mtdds/tpcds-kit/tools
echo "Generating queries for the small dataset..."
./dsqgen -DIRECTORY ../query_templates -INPUT ../query_templates/templates.lst -VERBOSE Y -QUALIFY Y -SCALE 1 -DIALECT netezza -OUTPUT_DIR ~/mtdds/files/step1Queries_TPCDS/s
echo "Generating queries for the medium dataset..."
./dsqgen -DIRECTORY ../query_templates -INPUT ../query_templates/templates.lst -VERBOSE Y -QUALIFY Y -SCALE 10 -DIALECT netezza -OUTPUT_DIR ~/mtdds/files/step1Queries_TPCDS/m
echo "Generating queries for the large dataset..."
./dsqgen -DIRECTORY ../query_templates -INPUT ../query_templates/templates.lst -VERBOSE Y -QUALIFY Y -SCALE 100 -DIALECT netezza -OUTPUT_DIR ~/mtdds/files/step1Queries_TPCDS/l
cd ~/mtdds/src/example
echo "Correcting syntax errors with regard to PostgreSQL..."
java ErrorCorrectionForPG ~/mtdds/files/step1Queries_TPCDS/s/query_0.sql ~/mtdds/files/step1Queries_TPCDS/s/query_0_corrected.sql
java ErrorCorrectionForPG ~/mtdds/files/step1Queries_TPCDS/m/query_0.sql ~/mtdds/files/step1Queries_TPCDS/m/query_0_corrected.sql
java ErrorCorrectionForPG ~/mtdds/files/step1Queries_TPCDS/l/query_0.sql ~/mtdds/files/step1Queries_TPCDS/l/query_0_corrected.sql
echo "Adding Explain Analyze ..."
java AddExplain ~/mtdds/files/step1Queries_TPCDS/s/query_0_corrected.sql ~/mtdds/files/step1QueriesWithExplain/s query_0_s ~/mtdds/files/step3ExecPlans/s
java AddExplain ~/mtdds/files/step1Queries_TPCDS/m/query_0_corrected.sql ~/mtdds/files/step1QueriesWithExplain/m query_0_m ~/mtdds/files/step3ExecPlans/m
java AddExplain ~/mtdds/files/step1Queries_TPCDS/l/query_0_corrected.sql ~/mtdds/files/step1QueriesWithExplain/l query_0_l ~/mtdds/files/step3ExecPlans/l
echo "Enabling nest loop join for some queries ..."
java EnableNLforExists ~/mtdds/files/step1QueriesWithExplain/s/query_0_s.sql ~/mtdds/files/step1QueriesWithExplain/s/query_0_s_pgxl.sql
java EnableNLforExists ~/mtdds/files/step1QueriesWithExplain/m/query_0_m.sql ~/mtdds/files/step1QueriesWithExplain/m/query_0_m_pgxl.sql
java EnableNLforExists ~/mtdds/files/step1QueriesWithExplain/l/query_0_l.sql ~/mtdds/files/step1QueriesWithExplain/l/query_0_l_pgxl.sql
echo "Finished."
