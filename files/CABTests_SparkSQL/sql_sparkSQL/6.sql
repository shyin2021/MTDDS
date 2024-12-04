select
    sum(l_extendedprice * l_discount) as revenue
from
    lineitem
where
        l_shipdate >= date :1
  and l_shipdate < date :1 + interval '1' year
  and l_discount between (:2 / 100.00) - 0.01 and (:2 / 100.00) + 0.01
  and l_quantity < :3;