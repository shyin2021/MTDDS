                                                                               QUERY PLAN                                                                               
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=337478.70..337478.95 rows=100 width=236) (actual time=23476.450..23476.459 rows=100 loops=1)
   ->  Sort  (cost=337478.70..337837.90 rows=143681 width=236) (actual time=23476.449..23476.452 rows=100 loops=1)
         Sort Key: (avg(inventory.inv_quantity_on_hand)), item.i_product_name, item.i_brand, item.i_class, item.i_category
         Sort Method: top-N heapsort  Memory: 65kB
         ->  GroupAggregate  (cost=327659.94..331987.31 rows=143681 width=236) (actual time=10809.376..23439.678 rows=95906 loops=1)
               Group Key: item.i_product_name, item.i_brand, item.i_class, item.i_category
               Group Key: item.i_product_name, item.i_brand, item.i_class
               Group Key: item.i_product_name, item.i_brand
               Group Key: item.i_product_name
               Group Key: ()
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=327659.94..328609.20 rows=126568 width=208) (actual time=10808.776..20952.596 rows=5616000 loops=1)
 Planning time: 0.275 ms
 Execution time: 23536.426 ms
(13 rows)

