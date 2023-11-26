                                                                       QUERY PLAN                                                                       
--------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=169629.88..169629.88 rows=1 width=72) (actual time=4373.594..4373.594 rows=1 loops=1)
   ->  Sort  (cost=169629.88..169629.88 rows=1 width=72) (actual time=4373.593..4373.593 rows=1 loops=1)
         Sort Key: (count(DISTINCT cs1.cs_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=169629.86..169629.87 rows=1 width=72) (actual time=4373.570..4373.570 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=150983.74..169629.85 rows=1 width=16) (actual time=3460.441..4373.201 rows=679 loops=1)
 Planning time: 1.765 ms
 Execution time: 4380.753 ms
(8 rows)

SET
