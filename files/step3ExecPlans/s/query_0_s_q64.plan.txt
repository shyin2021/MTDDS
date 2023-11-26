                                                                                                                              QUERY PLAN                                                                                                                               
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=171089.60..171089.61 rows=1 width=1310) (actual time=3044.040..3044.040 rows=8 loops=1)
   Sort Key: cs1.product_name, cs1.store_name, cs2.cnt, cs1.s1, cs2.s1
   Sort Method: quicksort  Memory: 27kB
   CTE cs_ui
     ->  Remote Subquery Scan on all (dn0)  (cost=54045.48..54060.69 rows=103 width=68) (actual time=394.337..481.063 rows=17169 loops=1)
   CTE cross_sales
     ->  GroupAggregate  (cost=117028.75..117028.82 rows=1 width=267) (actual time=3043.902..3043.954 rows=55 loops=1)
           Group Key: i_item_sk, s_store_name, s_zip, ca_street_number, ca_street_name, ca_city, ca_zip, ca_street_number, ca_street_name, ca_city, ca_zip, d_year, d_year, d_year
           ->  Sort  (cost=117028.75..117028.75 rows=1 width=178) (actual time=3043.892..3043.894 rows=55 loops=1)
                 Sort Key: i_item_sk, s_store_name, s_zip, ca_street_number, ca_street_name, ca_city, ca_zip, ca_street_number, ca_street_name, ca_city, ca_zip, d_year, d_year, d_year
                 Sort Method: quicksort  Memory: 39kB
                 ->  Hash Join  (cost=100949.05..117028.74 rows=1 width=178) (actual time=2309.128..3043.803 rows=55 loops=1)
                       Hash Cond: (c_first_sales_date_sk = d_date_sk)
                       ->  Hash Join  (cost=99933.17..116012.86 rows=1 width=178) (actual time=2229.273..2963.904 rows=56 loops=1)
                             Hash Cond: (hd_income_band_sk = ib_income_band_sk)
                             ->  Hash Join  (cost=99877.27..115956.96 rows=1 width=182) (actual time=2203.768..2938.366 rows=56 loops=1)
                                   Hash Cond: (ss_promo_sk = p_promo_sk)
                                   ->  Hash Join  (cost=99873.02..115952.71 rows=1 width=186) (actual time=2177.177..2911.736 rows=56 loops=1)
                                         Hash Cond: (cd_demo_sk = ss_cdemo_sk)
                                         Join Filter: (cd_marital_status <> cd_marital_status)
                                         Rows Removed by Join Filter: 12
                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..20821.61 rows=640267 width=6) (actual time=26.428..461.142 rows=1920800 loops=1)
                                         ->  Hash  (cost=99873.01..99873.01 rows=1 width=192) (actual time=2132.266..2132.266 rows=68 loops=1)
                                               Buckets: 1024  Batches: 1  Memory Usage: 24kB
                                               ->  Hash Join  (cost=83793.31..99873.01 rows=1 width=192) (actual time=1380.996..2132.195 rows=68 loops=1)
                                                     Hash Cond: (ss_store_sk = s_store_sk)
                                                     ->  Hash Join  (cost=83777.69..99857.38 rows=1 width=180) (actual time=1354.490..2105.643 rows=68 loops=1)
                                                           Hash Cond: (hd_income_band_sk = ib_income_band_sk)
                                                           ->  Hash Join  (cost=83721.79..99801.48 rows=1 width=184) (actual time=1328.137..2079.247 rows=68 loops=1)
                                                                 Hash Cond: (c_current_hdemo_sk = hd_demo_sk)
                                                                 ->  Hash Join  (cost=83650.79..99730.48 rows=1 width=184) (actual time=1298.436..2049.500 rows=71 loops=1)
                                                                       Hash Cond: (ss_hdemo_sk = hd_demo_sk)
                                                                       ->  Hash Join  (cost=83579.79..99659.47 rows=1 width=184) (actual time=1268.693..2019.689 rows=72 loops=1)
                                                                             Hash Cond: (c_first_shipto_date_sk = d_date_sk)
                                                                             ->  Hash Join  (cost=82563.91..98643.60 rows=1 width=184) (actual time=1207.956..1958.894 rows=73 loops=1)
                                                                                   Hash Cond: (c_current_addr_sk = ca_address_sk)
                                                                                   ->  Hash Join  (cost=81826.90..97906.59 rows=1 width=148) (actual time=1146.279..1897.154 rows=73 loops=1)
                                                                                         Hash Cond: (cd_demo_sk = c_current_cdemo_sk)
                                                                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..20821.61 rows=640267 width=6) (actual time=26.523..464.162 rows=1920800 loops=1)
                                                                                         ->  Hash  (cost=81826.89..81826.89 rows=1 width=150) (actual time=1114.401..1114.401 rows=73 loops=1)
                                                                                               Buckets: 1024  Batches: 1  Memory Usage: 22kB
                                                                                               ->  Hash Join  (cost=72004.38..81826.89 rows=1 width=150) (actual time=991.347..1114.332 rows=75 loops=1)
                                                                                                     Hash Cond: (ss_customer_sk = c_customer_sk)
                                                                                                     ->  Hash Join  (cost=70332.39..80154.90 rows=1 width=134) (actual time=902.098..1025.023 rows=75 loops=1)
                                                                                                           Hash Cond: (ss_addr_sk = ca_address_sk)
                                                                                                           ->  Hash Join  (cost=69595.38..79417.89 rows=1 width=98) (actual time=839.608..962.479 rows=77 loops=1)
                                                                                                                 Hash Cond: (ss_sold_date_sk = d_date_sk)
                                                                                                                 ->  Hash Join  (cost=68579.50..78402.01 rows=1 width=98) (actual time=780.914..903.728 rows=84 loops=1)
                                                                                                                       Hash Cond: ((sr_item_sk = ss_item_sk) AND (sr_ticket_number = ss_ticket_number))
                                                                                                                       ->  Remote Subquery Scan on all (dn0)  (cost=100.00..11503.82 rows=287514 width=8) (actual time=26.523..100.351 rows=287514 loops=1)
                                                                                                                       ->  Hash  (cost=68579.37..68579.37 rows=9 width=110) (actual time=750.959..750.959 rows=1005 loops=1)
                                                                                                                             Buckets: 1024  Batches: 1  Memory Usage: 153kB
                                                                                                                             ->  Hash Join  (cost=1578.38..68579.37 rows=9 width=110) (actual time=532.829..750.701 rows=1005 loops=1)
                                                                                                                                   Hash Cond: (ss_item_sk = cs_ui.cs_item_sk)
                                                                                                                                   ->  Remote Subquery Scan on all (dn0)  (cost=1675.04..68830.37 rows=1440 width=106) (actual time=42.053..258.798 rows=1005 loops=1)
                                                                                                                                   ->  Hash  (cost=2.06..2.06 rows=103 width=4) (actual time=490.756..490.756 rows=17169 loops=1)
                                                                                                                                         Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 860kB
                                                                                                                                         ->  CTE Scan on cs_ui  (cost=0.00..2.06 rows=103 width=4) (actual time=394.349..489.103 rows=17169 loops=1)
                                                                                                                 ->  Hash  (cost=1128.05..1128.05 rows=24350 width=8) (actual time=58.678..58.678 rows=73049 loops=1)
                                                                                                                       Buckets: 131072 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 3878kB
                                                                                                                       ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1128.05 rows=24350 width=8) (actual time=26.809..43.558 rows=73049 loops=1)
                                                                                                           ->  Hash  (cost=1445.35..1445.35 rows=16667 width=44) (actual time=62.474..62.474 rows=50000 loops=1)
                                                                                                                 Buckets: 65536 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 4315kB
                                                                                                                 ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1445.35 rows=16667 width=44) (actual time=26.583..39.823 rows=50000 loops=1)
                                                                                                     ->  Hash  (cost=2321.99..2321.99 rows=33333 width=24) (actual time=89.199..89.199 rows=100000 loops=1)
                                                                                                           Buckets: 131072 (originally 65536)  Batches: 1 (originally 1)  Memory Usage: 6439kB
                                                                                                           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..2321.99 rows=33333 width=24) (actual time=26.461..51.677 rows=100000 loops=1)
                                                                                   ->  Hash  (cost=1445.35..1445.35 rows=16667 width=44) (actual time=61.662..61.662 rows=50000 loops=1)
                                                                                         Buckets: 65536 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 4315kB
                                                                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1445.35 rows=16667 width=44) (actual time=26.133..39.208 rows=50000 loops=1)
                                                                             ->  Hash  (cost=1128.05..1128.05 rows=24350 width=8) (actual time=60.709..60.709 rows=73049 loops=1)
                                                                                   Buckets: 131072 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 3878kB
                                                                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1128.05 rows=24350 width=8) (actual time=26.042..45.301 rows=73049 loops=1)
                                                                       ->  Hash  (cost=172.20..172.20 rows=2400 width=8) (actual time=29.734..29.734 rows=7200 loops=1)
                                                                             Buckets: 8192 (originally 4096)  Batches: 1 (originally 1)  Memory Usage: 346kB
                                                                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..172.20 rows=2400 width=8) (actual time=26.404..28.279 rows=7200 loops=1)
                                                                 ->  Hash  (cost=172.20..172.20 rows=2400 width=8) (actual time=29.693..29.693 rows=7200 loops=1)
                                                                       Buckets: 8192 (originally 4096)  Batches: 1 (originally 1)  Memory Usage: 346kB
                                                                       ->  Remote Subquery Scan on all (dn0)  (cost=100.00..172.20 rows=2400 width=8) (actual time=26.357..28.304 rows=7200 loops=1)
                                                           ->  Hash  (cost=148.76..148.76 rows=2040 width=4) (actual time=26.348..26.348 rows=20 loops=1)
                                                                 Buckets: 2048  Batches: 1  Memory Usage: 17kB
                                                                 ->  Remote Subquery Scan on all (dn0)  (cost=100.00..148.76 rows=2040 width=4) (actual time=26.336..26.338 rows=20 loops=1)
                                                     ->  Hash  (cost=118.75..118.75 rows=250 width=20) (actual time=26.501..26.501 rows=12 loops=1)
                                                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                                           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..118.75 rows=250 width=20) (actual time=26.486..26.488 rows=12 loops=1)
                                   ->  Hash  (cost=103.90..103.90 rows=100 width=4) (actual time=26.587..26.587 rows=300 loops=1)
                                         Buckets: 1024  Batches: 1  Memory Usage: 19kB
                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..103.90 rows=100 width=4) (actual time=26.511..26.538 rows=300 loops=1)
                             ->  Hash  (cost=148.76..148.76 rows=2040 width=4) (actual time=25.496..25.496 rows=20 loops=1)
                                   Buckets: 2048  Batches: 1  Memory Usage: 17kB
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..148.76 rows=2040 width=4) (actual time=25.482..25.485 rows=20 loops=1)
                       ->  Hash  (cost=1128.05..1128.05 rows=24350 width=8) (actual time=79.830..79.830 rows=73049 loops=1)
                             Buckets: 131072 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 3878kB
                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1128.05 rows=24350 width=8) (actual time=42.104..64.578 rows=73049 loops=1)
   ->  Hash Join  (cost=0.04..0.09 rows=1 width=1310) (actual time=3044.017..3044.023 rows=8 loops=1)
         Hash Cond: ((cs1.item_sk = cs2.item_sk) AND ((cs1.store_name)::text = (cs2.store_name)::text) AND (cs1.store_zip = cs2.store_zip))
         Join Filter: (cs2.cnt <= cs1.cnt)
         ->  CTE Scan on cross_sales cs1  (cost=0.00..0.02 rows=1 width=1206) (actual time=3043.936..3043.940 rows=8 loops=1)
               Filter: (syear = 1999)
               Rows Removed by Filter: 47
         ->  Hash  (cost=0.02..0.02 rows=1 width=274) (actual time=0.067..0.067 rows=11 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  CTE Scan on cross_sales cs2  (cost=0.00..0.02 rows=1 width=274) (actual time=0.001..0.063 rows=11 loops=1)
                     Filter: (syear = 2000)
                     Rows Removed by Filter: 44
 Planning time: 63.587 ms
 Execution time: 3072.380 ms
(107 rows)

