                                                                                    QUERY PLAN                                                                                    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=81733.31..81733.56 rows=100 width=273) (actual time=6260.154..6260.163 rows=100 loops=1)
   ->  Sort  (cost=81733.31..81786.72 rows=21366 width=273) (actual time=6260.154..6260.157 rows=100 loops=1)
         Sort Key: dw2.i_category, dw2.i_class, dw2.i_brand, dw2.i_product_name, dw2.d_year, dw2.d_qoy, dw2.d_moy, dw2.s_store_id, dw2.sumsales, dw2.rk
         Sort Method: top-N heapsort  Memory: 51kB
         ->  Subquery Scan on dw2  (cost=78833.50..80916.72 rows=21366 width=273) (actual time=5776.017..6259.559 rows=1100 loops=1)
               Filter: (dw2.rk <= 100)
               Rows Removed by Filter: 523683
               ->  WindowAgg  (cost=78833.50..80115.48 rows=64099 width=273) (actual time=5776.016..6239.153 rows=524783 loops=1)
                     ->  Sort  (cost=78833.50..78993.75 rows=64099 width=265) (actual time=5776.009..5833.422 rows=524783 loops=1)
                           Sort Key: dw1.i_category, dw1.sumsales DESC
                           Sort Method: quicksort  Memory: 247430kB
                           ->  Subquery Scan on dw1  (cost=71776.71..73715.83 rows=64099 width=265) (actual time=3208.194..4604.925 rows=524783 loops=1)
                                 ->  GroupAggregate  (cost=71776.71..73074.84 rows=64099 width=265) (actual time=3208.193..4565.437 rows=524783 loops=1)
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy, s_store_id
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year, d_qoy
                                       Group Key: i_category, i_class, i_brand, i_product_name, d_year
                                       Group Key: i_category, i_class, i_brand, i_product_name
                                       Group Key: i_category, i_class, i_brand
                                       Group Key: i_category, i_class
                                       Group Key: i_category
                                       Group Key: ()
                                       ->  Remote Subquery Scan on all (dn0)  (cost=71776.71..71883.18 rows=14197 width=243) (actual time=3208.158..3477.276 rows=536789 loops=1)
 Planning time: 0.375 ms
 Execution time: 6280.831 ms
(25 rows)

