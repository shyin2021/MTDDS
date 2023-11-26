                                                                     QUERY PLAN                                                                     
----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=290780.03..290780.28 rows=100 width=100) (actual time=521.013..521.022 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=141095.22..141096.65 rows=57 width=49) (actual time=259.528..260.574 rows=620 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=141095.22..141095.65 rows=57 width=23) (actual time=259.499..260.245 rows=1148 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=97233.44..97234.17 rows=29 width=49) (actual time=159.941..160.619 rows=446 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=97233.44..97233.66 rows=29 width=23) (actual time=159.932..160.407 rows=649 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=52441.80..52442.15 rows=14 width=49) (actual time=98.226..98.529 rows=250 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=52441.80..52441.90 rows=14 width=23) (actual time=98.217..98.406 rows=288 loops=1)
   ->  Sort  (cost=7.07..7.32 rows=100 width=100) (actual time=521.012..521.015 rows=100 loops=1)
         Sort Key: (sum(ss.total_sales)), ss.i_item_id
         Sort Method: top-N heapsort  Memory: 38kB
         ->  HashAggregate  (cost=2.50..3.75 rows=100 width=100) (actual time=520.592..520.761 rows=748 loops=1)
               Group Key: ss.i_item_id
               ->  Append  (cost=0.00..2.00 rows=100 width=100) (actual time=259.531..520.120 rows=1316 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..1.14 rows=57 width=100) (actual time=259.530..260.712 rows=620 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..0.58 rows=29 width=100) (actual time=159.943..160.729 rows=446 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..0.28 rows=14 width=100) (actual time=98.228..98.596 rows=250 loops=1)
 Planning time: 2.103 ms
 Execution time: 528.459 ms
(24 rows)

