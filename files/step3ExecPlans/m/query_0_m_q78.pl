                                                                                                                                                                                                               QUERY PLAN                                                                                                                                                                                                                
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=864019.15..864019.40 rows=100 width=188) (actual time=64659.845..64659.857 rows=100 loops=1)
   CTE ws
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=163114.16..188336.63 rows=776076 width=84) (actual time=8311.816..9903.080 rows=1295175 loops=1)
   CTE cs
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=331019.77..381360.39 rows=1548942 width=84) (actual time=19722.658..23016.438 rows=2578139 loops=1)
   CTE ss
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=238132.47..239223.77 rows=72753 width=84) (actual time=21880.023..28320.252 rows=4888253 loops=1)
   ->  Sort  (cost=55098.36..55098.87 rows=202 width=188) (actual time=64659.843..64659.849 rows=100 loops=1)
         Sort Key: ss.ss_item_sk, ss.ss_customer_sk, ss.ss_qty DESC, ss.ss_wc DESC, ss.ss_sp DESC, ((COALESCE(ws.ws_qty, '0'::bigint) + COALESCE(cs.cs_qty, '0'::bigint))), ((COALESCE(ws.ws_wc, '0'::numeric) + COALESCE(cs.cs_wc, '0'::numeric))), ((COALESCE(ws.ws_sp, '0'::numeric) + COALESCE(cs.cs_sp, '0'::numeric))), (round(((ss.ss_qty / (COALESCE(ws.ws_qty, '0'::bigint) + COALESCE(cs.cs_qty, '0'::bigint))))::numeric, 2))
         Sort Method: top-N heapsort  Memory: 45kB
         ->  Hash Right Join  (cost=37071.97..55090.64 rows=202 width=188) (actual time=62941.805..64659.397 rows=408 loops=1)
               Hash Cond: ((ws.ws_sold_year = ss.ss_sold_year) AND (ws.ws_item_sk = ss.ss_item_sk) AND (ws.ws_customer_sk = ss.ss_customer_sk))
               Filter: ((COALESCE(ws.ws_qty, '0'::bigint) > 0) OR (COALESCE(cs.cs_qty, '0'::bigint) > 0))
               Rows Removed by Filter: 973743
               ->  CTE Scan on ws  (cost=0.00..17461.71 rows=3880 width=84) (actual time=8626.983..10086.977 rows=258216 loops=1)
                     Filter: (ws_sold_year = 1999)
                     Rows Removed by Filter: 1036959
               ->  Hash  (cost=37065.60..37065.60 rows=364 width=156) (actual time=54312.999..54312.999 rows=974151 loops=1)
                     Buckets: 1048576 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 81827kB
                     ->  Merge Left Join  (cost=37003.91..37065.60 rows=364 width=156) (actual time=53811.243..54146.526 rows=974151 loops=1)
                           Merge Cond: ((ss.ss_item_sk = cs.cs_item_sk) AND (ss.ss_customer_sk = cs.cs_customer_sk))
                           Join Filter: (cs.cs_sold_year = ss.ss_sold_year)
                           ->  Sort  (cost=1652.43..1653.34 rows=364 width=84) (actual time=30081.767..30205.705 rows=974151 loops=1)
                                 Sort Key: ss.ss_item_sk, ss.ss_customer_sk
                                 Sort Method: quicksort  Memory: 100512kB
                                 ->  CTE Scan on ss  (cost=0.00..1636.94 rows=364 width=84) (actual time=21880.029..29544.740 rows=974151 loops=1)
                                       Filter: (ss_sold_year = 1999)
                                       Rows Removed by Filter: 3914102
                           ->  Sort  (cost=35351.49..35370.85 rows=7745 width=84) (actual time=23729.462..23747.605 rows=513920 loops=1)
                                 Sort Key: cs.cs_item_sk, cs.cs_customer_sk
                                 Sort Method: quicksort  Memory: 52416kB
                                 ->  CTE Scan on cs  (cost=0.00..34851.19 rows=7745 width=84) (actual time=20491.269..23590.201 rows=513920 loops=1)
                                       Filter: (cs_sold_year = 1999)
                                       Rows Removed by Filter: 2064219
 Planning time: 17.402 ms
 Execution time: 64865.336 ms
(36 rows)

