                                                                            QUERY PLAN                                                                            
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=203526.49..203526.74 rows=100 width=236) (actual time=14236.552..14236.560 rows=100 loops=1)
   ->  Sort  (cost=203526.49..203785.94 rows=103781 width=236) (actual time=14236.551..14236.554 rows=100 loops=1)
         Sort Key: (avg(inventory.inv_quantity_on_hand)), item.i_product_name, item.i_brand, item.i_class, item.i_category
         Sort Method: top-N heapsort  Memory: 63kB
         ->  GroupAggregate  (cost=196804.19..199560.06 rows=103781 width=236) (actual time=7899.481..14217.348 rows=51947 loops=1)
               Group Key: item.i_product_name, item.i_brand, item.i_class, item.i_category
               Group Key: item.i_product_name, item.i_brand, item.i_class
               Group Key: item.i_product_name, item.i_brand
               Group Key: item.i_product_name
               Group Key: ()
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=196804.19..197351.17 rows=72930 width=208) (actual time=7898.791..12785.587 rows=3380260 loops=1)
 Planning time: 0.334 ms
 Execution time: 14282.863 ms
(13 rows)

