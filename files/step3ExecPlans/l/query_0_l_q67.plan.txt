                                                                                         QUERY PLAN                                                                                          
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=247277.48..247277.73 rows=100 width=273) (actual time=17095.629..17095.638 rows=100 loops=1)
   ->  Sort  (cost=247277.48..247457.90 rows=72170 width=273) (actual time=17095.628..17095.631 rows=100 loops=1)
         Sort Key: dw2.i_category, dw2.i_class, dw2.i_brand, dw2.i_product_name, dw2.d_year, dw2.d_qoy, dw2.d_moy, dw2.s_store_id, dw2.sumsales, dw2.rk
         Sort Method: top-N heapsort  Memory: 51kB
         ->  Subquery Scan on dw2  (cost=237482.65..244519.19 rows=72170 width=273) (actual time=15185.817..17095.153 rows=1101 loops=1)
               Filter: (dw2.rk <= 100)
               Rows Removed by Filter: 1626062
               ->  WindowAgg  (cost=237482.65..241812.83 rows=216509 width=273) (actual time=15185.815..17026.786 rows=1627163 loops=1)
                     ->  Sort  (cost=237482.65..238023.92 rows=216509 width=265) (actual time=15185.809..15699.576 rows=1627163 loops=1)
                           Sort Key: dw1.i_category, dw1.sumsales DESC
                           Sort Method: external merge  Disk: 395432kB
                           ->  Subquery Scan on dw1  (cost=211884.20..218295.55 rows=216509 width=265) (actual time=3643.196..11225.614 rows=1627163 loops=1)
                                 ->  GroupAggregate  (cost=211884.20..216130.46 rows=216509 width=265) (actual time=3643.196..11052.451 rows=1627163 loops=1)
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy, s_store_id
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year
                                       Group Key: i_category, i_class, i_brand, i_product_name
                                       Group Key: i_category, i_class, i_brand
                                       Group Key: i_category, i_class
                                       Group Key: i_category
                                       Group Key: ()
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=211884.20..212214.18 rows=43997 width=243) (actual time=3643.165..8753.958 rows=1606195 loops=1)
 Planning time: 0.413 ms
 Execution time: 17189.403 ms
(25 rows)

