                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1541106.18..1541106.18 rows=1 width=72) (actual time=19389.112..19389.112 rows=1 loops=1)
   CTE ws_wh
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=69926.06..616220.93 rows=9302566 width=12) (actual time=3670.387..6348.410 rows=13298000 loops=1)
   ->  Sort  (cost=924885.25..924885.26 rows=1 width=72) (actual time=19389.110..19389.110 rows=1 loops=1)
         Sort Key: (count(DISTINCT ws_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=924885.23..924885.24 rows=1 width=72) (actual time=19389.104..19389.104 rows=1 loops=1)
               ->  Hash Join  (cost=879750.42..924885.21 rows=2 width=16) (actual time=19388.987..19389.076 rows=64 loops=1)
                     Hash Cond: (ws_order_number = wr_order_number)
                     ->  Hash Join  (cost=214383.11..259517.88 rows=3 width=20) (actual time=14414.382..14414.455 rows=100 loops=1)
                           Hash Cond: (ws_order_number = ws_wh.ws_order_number)
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=5170.87..50305.72 rows=6 width=16) (actual time=94.849..94.858 rows=100 loops=1)
                           ->  Hash  (cost=209309.74..209309.74 rows=200 width=4) (actual time=14319.510..14319.510 rows=120000 loops=1)
                                 Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 5243kB
                                 ->  HashAggregate  (cost=209307.74..209309.74 rows=200 width=4) (actual time=14292.257..14309.006 rows=120000 loops=1)
                                       Group Key: ws_wh.ws_order_number
                                       ->  CTE Scan on ws_wh  (cost=0.00..186051.32 rows=9302566 width=4) (actual time=3670.399..12309.319 rows=13298000 loops=1)
                     ->  Hash  (cost=664131.05..664131.05 rows=98901 width=8) (actual time=4974.498..4974.498 rows=84785 loops=1)
                           Buckets: 131072  Batches: 1  Memory Usage: 4336kB
                           ->  HashAggregate  (cost=663142.04..664131.05 rows=98901 width=8) (actual time=4952.839..4965.281 rows=84785 loops=1)
                                 Group Key: wr_order_number
                                 ->  Hash Join  (cost=5886.65..629367.91 rows=13509654 width=8) (actual time=67.344..3156.714 rows=17383490 loops=1)
                                       Hash Cond: (ws_wh_1.ws_order_number = wr_order_number)
                                       ->  CTE Scan on ws_wh ws_wh_1  (cost=0.00..186051.32 rows=9302566 width=4) (actual time=0.032..930.573 rows=13298000 loops=1)
                                       ->  Hash  (cost=5483.95..5483.95 rows=143629 width=4) (actual time=66.764..66.765 rows=143629 loops=1)
                                             Buckets: 262144  Batches: 1  Memory Usage: 7098kB
                                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..5483.95 rows=143629 width=4) (actual time=0.884..28.723 rows=143629 loops=1)
 Planning time: 0.985 ms
 Execution time: 19425.773 ms
(29 rows)

