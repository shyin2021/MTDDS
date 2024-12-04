with r1 as
    (select
            l_partkey, 0.2 * avg(l_quantity) as avg
    from
        lineitem
    group by
        l_partkey)
select
        sum(l_extendedprice) / 7.0 as avg_yearly
from
    lineitem,
    part,
    r1
where
        p_partkey = lineitem.l_partkey
  and p_brand = :1
  and p_container = :2
  and l_quantity < r1.avg
  and r1.l_partkey = p_partkey;
