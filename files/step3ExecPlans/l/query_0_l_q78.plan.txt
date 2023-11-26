                                                                                                                                                                                              QUERY PLAN                                                                                                                                                                                               
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=2223933.03..2223933.28 rows=100 width=180) (actual time=30023.807..30023.816 rows=100 loops=1)
   CTE ws
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=268751.69..313058.48 rows=1363286 width=84) (actual time=1279.080..4191.248 rows=1944130 loops=1)
   CTE cs
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=587576.15..676360.49 rows=2731826 width=84) (actual time=2630.920..7332.681 rows=3867262 loops=1)
   CTE ss
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=920053.78..1049091.03 rows=3970377 width=84) (actual time=5377.037..14715.857 rows=7326822 loops=1)
   ->  Sort  (cost=185423.02..185450.60 rows=11029 width=180) (actual time=30023.806..30023.809 rows=100 loops=1)
         Sort Key: ss.ss_qty DESC, ss.ss_wc DESC, ss.ss_sp DESC, ((COALESCE(ws.ws_qty, '0'::bigint) + COALESCE(cs.cs_qty, '0'::bigint))), ((COALESCE(ws.ws_wc, '0'::numeric) + COALESCE(cs.cs_wc, '0'::numeric))), ((COALESCE(ws.ws_sp, '0'::numeric) + COALESCE(cs.cs_sp, '0'::numeric))), (round(((ss.ss_qty / (COALESCE(ws.ws_qty, '0'::bigint) + COALESCE(cs.cs_qty, '0'::bigint))))::numeric, 2))
         Sort Method: top-N heapsort  Memory: 47kB
         ->  Merge Left Join  (cost=184262.84..185001.50 rows=11029 width=180) (actual time=29458.750..30023.506 rows=526 loops=1)
               Merge Cond: ((ss.ss_item_sk = ws.ws_item_sk) AND (ss.ss_customer_sk = ws.ws_customer_sk))
               Join Filter: (ws.ws_sold_year = ss.ss_sold_year)
               Filter: ((COALESCE(ws.ws_qty, '0'::bigint) > 0) OR (COALESCE(cs.cs_qty, '0'::bigint) > 0))
               Rows Removed by Filter: 1460997
               ->  Merge Left Join  (cost=153154.91..153490.98 rows=19852 width=156) (actual time=24713.102..25117.350 rows=1461523 loops=1)
                     Merge Cond: ((ss.ss_item_sk = cs.cs_item_sk) AND (ss.ss_customer_sk = cs.cs_customer_sk))
                     Join Filter: (cs.cs_sold_year = ss.ss_sold_year)
                     ->  Sort  (cost=90750.62..90800.25 rows=19852 width=84) (actual time=16524.435..16651.732 rows=1461523 loops=1)
                           Sort Key: ss.ss_item_sk, ss.ss_customer_sk
                           Sort Method: external merge  Disk: 70544kB
                           ->  CTE Scan on ss  (cost=0.00..89333.48 rows=19852 width=84) (actual time=7519.511..16050.634 rows=1461523 loops=1)
                                 Filter: (ss_sold_year = 1999)
                                 Rows Removed by Filter: 5865299
                     ->  Sort  (cost=62404.29..62438.44 rows=13659 width=84) (actual time=8188.662..8213.087 rows=769842 loops=1)
                           Sort Key: cs.cs_item_sk, cs.cs_customer_sk
                           Sort Method: quicksort  Memory: 84685kB
                           ->  CTE Scan on cs  (cost=0.00..61466.08 rows=13659 width=84) (actual time=3651.952..8017.727 rows=769843 loops=1)
                                 Filter: (cs_sold_year = 1999)
                                 Rows Removed by Filter: 3097419
               ->  Sort  (cost=31107.93..31124.97 rows=6816 width=84) (actual time=4745.512..4758.236 rows=388161 loops=1)
                     Sort Key: ws.ws_item_sk, ws.ws_customer_sk
                     Sort Method: quicksort  Memory: 42613kB
                     ->  CTE Scan on ws  (cost=0.00..30673.93 rows=6816 width=84) (actual time=1857.422..4636.343 rows=388161 loops=1)
                           Filter: (ws_sold_year = 1999)
                           Rows Removed by Filter: 1555969
 Planning time: 1.445 ms
 Execution time: 30144.515 ms
(38 rows)

