                                                                                       QUERY PLAN                                                                                        
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=163279.03..163279.28 rows=100 width=273) (actual time=12417.515..12417.524 rows=100 loops=1)
   ->  Sort  (cost=163279.03..163394.61 rows=46231 width=273) (actual time=12417.514..12417.517 rows=100 loops=1)
         Sort Key: dw2.i_category, dw2.i_class, dw2.i_brand, dw2.i_product_name, dw2.d_year, dw2.d_qoy, dw2.d_moy, dw2.s_store_id, dw2.sumsales, dw2.rk
         Sort Method: top-N heapsort  Memory: 51kB
         ->  Subquery Scan on dw2  (cost=157004.56..161512.11 rows=46231 width=273) (actual time=11294.250..12417.013 rows=1100 loops=1)
               Filter: (dw2.rk <= 100)
               Rows Removed by Filter: 1042362
               ->  WindowAgg  (cost=157004.56..159778.44 rows=138694 width=273) (actual time=11294.248..12375.106 rows=1043462 loops=1)
                     ->  Sort  (cost=157004.56..157351.29 rows=138694 width=265) (actual time=11294.243..11543.645 rows=1043462 loops=1)
                           Sort Key: dw1.i_category, dw1.sumsales DESC
                           Sort Method: external merge  Disk: 253440kB
                           ->  Subquery Scan on dw1  (cost=141083.36..145159.02 rows=138694 width=265) (actual time=3369.250..8677.643 rows=1043462 loops=1)
                                 ->  GroupAggregate  (cost=141083.36..143772.08 rows=138694 width=265) (actual time=3369.249..8520.122 rows=1043462 loops=1)
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy, s_store_id
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year
                                       Group Key: i_category, i_class, i_brand, i_product_name
                                       Group Key: i_category, i_class, i_brand
                                       Group Key: i_category, i_class
                                       Group Key: i_category
                                       Group Key: ()
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=141083.36..141288.01 rows=27287 width=243) (actual time=3369.235..6580.850 rows=1070024 loops=1)
 Planning time: 0.487 ms
 Execution time: 12467.219 ms
(25 rows)

