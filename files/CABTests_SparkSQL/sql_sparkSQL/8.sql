select
    extract(year from o_orderdate) as o_year,
    sum(case
            when n2.n_name = :1 then l_extendedprice * (1 - l_discount)
            else 0
        end) / sum(l_extendedprice * (1 - l_discount) ) as mkt_share
from
    orders,
    lineitem,
    part,
    customer,
    nation n1,
    nation n2,
    region,
    supplier
where
       p_partkey = l_partkey
    and s_suppkey = l_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_nationkey = n1.n_nationkey
    and n1.n_regionkey = r_regionkey
    and r_name = :2
    and s_nationkey = n2.n_nationkey
    and o_orderdate between date '1995-01-01' and date '1996-12-31'
    and p_type = :3
group by
    extract(year from o_orderdate)
order by
    o_year;
