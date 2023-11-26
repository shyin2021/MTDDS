                                                                                                         QUERY PLAN                                                                                                          
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=788990.71..788990.71 rows=1 width=80) (actual time=3458.497..3458.506 rows=100 loops=1)
   CTE all_sales
     ->  HashAggregate  (cost=780340.38..782201.41 rows=148882 width=60) (actual time=3448.957..3452.431 rows=10624 loops=1)
           Group Key: d_year, i_brand_id, i_class_id, i_category_id, i_manufact_id
           ->  HashAggregate  (cost=724509.56..739397.78 rows=1488822 width=56) (actual time=2710.481..3024.564 rows=1441793 loops=1)
                 Group Key: d_year, i_brand_id, i_class_id, i_category_id, i_manufact_id, ((cs_quantity - COALESCE(cr_return_quantity, 0))), ((cs_ext_sales_price - COALESCE(cr_return_amount, 0.0)))
                 ->  Append  (cost=25528.92..698455.17 rows=1488822 width=56) (actual time=80.142..1635.782 rows=1448371 loops=1)
                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=25528.92..216751.54 rows=425342 width=56) (actual time=80.141..592.008 rows=423336 loops=1)
                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=42047.76..355410.85 rows=850764 width=56) (actual time=115.005..765.849 rows=812971 loops=1)
                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=15469.84..111404.56 rows=212716 width=56) (actual time=59.852..202.560 rows=212064 loops=1)
   ->  Sort  (cost=6789.30..6789.31 rows=1 width=80) (actual time=3458.496..3458.499 rows=100 loops=1)
         Sort Key: ((curr_yr.sales_cnt - prev_yr.sales_cnt)), ((curr_yr.sales_amt - prev_yr.sales_amt))
         Sort Method: top-N heapsort  Memory: 48kB
         ->  Merge Join  (cost=6770.66..6789.29 rows=1 width=80) (actual time=3457.176..3458.393 rows=502 loops=1)
               Merge Cond: ((curr_yr.i_brand_id = prev_yr.i_brand_id) AND (curr_yr.i_class_id = prev_yr.i_class_id) AND (curr_yr.i_category_id = prev_yr.i_category_id) AND (curr_yr.i_manufact_id = prev_yr.i_manufact_id))
               Join Filter: (((curr_yr.sales_cnt)::numeric(17,2) / (prev_yr.sales_cnt)::numeric(17,2)) < 0.9)
               Rows Removed by Join Filter: 941
               ->  Sort  (cost=3385.33..3387.19 rows=744 width=60) (actual time=3455.292..3455.363 rows=1924 loops=1)
                     Sort Key: curr_yr.i_brand_id, curr_yr.i_class_id, curr_yr.i_category_id, curr_yr.i_manufact_id
                     Sort Method: quicksort  Memory: 208kB
                     ->  CTE Scan on all_sales curr_yr  (cost=0.00..3349.84 rows=744 width=60) (actual time=3448.969..3454.761 rows=2044 loops=1)
                           Filter: (d_year = 2000)
                           Rows Removed by Filter: 8580
               ->  Sort  (cost=3385.33..3387.19 rows=744 width=60) (actual time=1.857..1.925 rows=1751 loops=1)
                     Sort Key: prev_yr.i_brand_id, prev_yr.i_class_id, prev_yr.i_category_id, prev_yr.i_manufact_id
                     Sort Method: quicksort  Memory: 186kB
                     ->  CTE Scan on all_sales prev_yr  (cost=0.00..3349.84 rows=744 width=60) (actual time=0.001..0.654 rows=1755 loops=1)
                           Filter: (d_year = 1999)
                           Rows Removed by Filter: 8869
 Planning time: 2.755 ms
 Execution time: 3507.060 ms
(31 rows)

