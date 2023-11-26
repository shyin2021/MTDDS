                                                                         QUERY PLAN                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=217239.72..217239.88 rows=63 width=142) (actual time=346.859..346.896 rows=100 loops=1)
   ->  Sort  (cost=217239.72..217239.88 rows=63 width=142) (actual time=346.857..346.872 rows=100 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_brand, item.i_brand_id, item.i_manufact_id, item.i_manufact
         Sort Method: top-N heapsort  Memory: 68kB
         ->  Finalize GroupAggregate  (cost=217229.29..217237.84 rows=63 width=142) (actual time=342.366..345.544 rows=332 loops=1)
               Group Key: item.i_brand, item.i_brand_id, item.i_manufact_id, item.i_manufact
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=217229.29..217236.27 rows=52 width=142) (actual time=342.336..344.441 rows=335 loops=1)
 Planning time: 0.954 ms
 Execution time: 354.196 ms
(9 rows)

