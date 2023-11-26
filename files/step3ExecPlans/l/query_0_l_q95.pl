                                                                                         QUERY PLAN                                                                                          
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=2200412.85..2200412.86 rows=1 width=72) (actual time=45237.067..45237.068 rows=1 loops=1)
   CTE ws_wh
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=610462.56..890182.02 rows=12549146 width=12) (actual time=427.144..26381.239 rows=20793982 loops=1)
   ->  Sort  (cost=1310230.84..1310230.84 rows=1 width=72) (actual time=45237.067..45237.067 rows=1 loops=1)
         Sort Key: (count(DISTINCT ws_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=1310230.82..1310230.83 rows=1 width=72) (actual time=45237.061..45237.061 rows=1 loops=1)
               ->  Hash Join  (cost=1242486.59..1310230.80 rows=2 width=16) (actual time=45236.770..45237.006 rows=221 loops=1)
                     Hash Cond: (ws_order_number = ws_wh.ws_order_number)
                     ->  Hash Join  (cost=960126.30..1027870.48 rows=3 width=24) (actual time=7697.718..7697.887 rows=221 loops=1)
                           Hash Cond: (ws_order_number = wr_order_number)
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=5834.19..73578.48 rows=8 width=16) (actual time=96.591..96.616 rows=291 loops=1)
                           ->  Hash  (cost=952326.89..952326.89 rows=165218 width=8) (actual time=7600.567..7600.567 rows=127164 loops=1)
                                 Buckets: 262144  Batches: 1  Memory Usage: 7016kB
                                 ->  HashAggregate  (cost=950674.71..952326.89 rows=165218 width=8) (actual time=7563.395..7581.881 rows=127164 loops=1)
                                       Group Key: wr_order_number
                                       ->  Hash Join  (cost=8830.23..909758.28 rows=16366572 width=8) (actual time=107.051..4845.028 rows=27168264 loops=1)
                                             Hash Cond: (ws_wh_1.ws_order_number = wr_order_number)
                                             ->  CTE Scan on ws_wh ws_wh_1  (cost=0.00..250982.92 rows=12549146 width=4) (actual time=0.025..1439.761 rows=20793982 loops=1)
                                             ->  Hash  (cost=8176.06..8176.06 rows=215477 width=4) (actual time=106.494..106.494 rows=215477 loops=1)
                                                   Buckets: 262144  Batches: 1  Memory Usage: 9624kB
                                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..8176.06 rows=215477 width=4) (actual time=9.745..60.710 rows=215477 loops=1)
                     ->  Hash  (cost=282357.79..282357.79 rows=200 width=4) (actual time=37539.046..37539.046 rows=180000 loops=1)
                           Buckets: 262144 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 8377kB
                           ->  HashAggregate  (cost=282355.79..282357.79 rows=200 width=4) (actual time=37499.250..37523.745 rows=180000 loops=1)
                                 Group Key: ws_wh.ws_order_number
                                 ->  CTE Scan on ws_wh  (cost=0.00..250982.92 rows=12549146 width=4) (actual time=427.157..34782.336 rows=20793982 loops=1)
 Planning time: 0.961 ms
 Execution time: 45313.773 ms
(29 rows)

