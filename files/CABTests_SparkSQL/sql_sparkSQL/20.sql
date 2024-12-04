with r1 as
    (select
        l_partkey,
        l_suppkey,
        0.5 * sum(l_quantity) as half_sum
     from
        lineitem,
        partsupp
     where
        l_partkey = ps_partkey
       and l_suppkey = ps_suppkey
       and l_shipdate >= date :2
       and l_shipdate < date :2 + interval '1' year
     group by
       l_partkey,
       l_suppkey)
select
    s_name,
    s_address
from
    supplier,
    nation,
    partsupp,
    part,
    r1
where
     s_suppkey = ps_suppkey 
     and ps_partkey = p_partkey
     and p_name like :1 || '%'
     and l_partkey = ps_partkey
     and l_suppkey = ps_suppkey
     and ps_availqty > half_sum 
     and s_nationkey = n_nationkey
     and n_name = :3
order by
    s_name;
