select
    l_orderkey,
    sum(l_extendedprice * (1 - l_discount)) as revenue,
    o_orderdate,
    o_shippriority
from lineitem,
     (select *
      from customer, orders
      where c_mktsegment = :1
       and c_custkey = o_custkey
     ) r1
where
  l_orderkey = o_orderkey
  and o_orderdate < date :2
  and l_shipdate > date :2
group by
    l_orderkey,
    o_orderdate,
    o_shippriority
order by
    revenue desc,
    o_orderdate
limit 10;
