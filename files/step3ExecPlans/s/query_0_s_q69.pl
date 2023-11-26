                                                                                                           QUERY PLAN                                                                                                            
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=97917.89..97921.14 rows=100 width=64) (actual time=543.193..543.229 rows=100 loops=1)
   ->  GroupAggregate  (cost=97917.89..97930.24 rows=380 width=64) (actual time=543.191..543.222 rows=100 loops=1)
         Group Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating
         ->  Sort  (cost=97917.89..97918.84 rows=380 width=40) (actual time=543.187..543.190 rows=109 loops=1)
               Sort Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating
               Sort Method: quicksort  Memory: 81kB
               ->  Nested Loop Anti Join  (cost=93655.89..97901.61 rows=380 width=40) (actual time=356.518..541.676 rows=719 loops=1)
                     ->  Nested Loop  (cost=93655.55..95301.58 rows=401 width=44) (actual time=355.733..464.004 rows=760 loops=1)
                           ->  Remote Subquery Scan on all (dn0,dn1,dn2)  (cost=93755.37..95206.07 rows=401 width=8) (actual time=355.518..355.796 rows=789 loops=1)
                           ->  Materialize  (cost=100.17..100.54 rows=1 width=44) (actual time=0.135..0.135 rows=1 loops=789)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=100.17..100.54 rows=1 width=44) (actual time=0.135..0.135 rows=1 loops=789)
                     ->  Materialize  (cost=100.34..106.49 rows=1 width=4) (actual time=0.101..0.101 rows=0 loops=760)
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.34..106.48 rows=1 width=4) (actual time=0.101..0.101 rows=0 loops=760)
 Planning time: 0.894 ms
 Execution time: 556.762 ms
(15 rows)

SET
