with L1L2 as (
  select
    s_name,
    l1.l_orderkey,
    l1.l_suppkey
  from
    supplier,
    lineitem l1,
    lineitem l2,
    orders,
    nation
  where
        s_suppkey = l1.l_suppkey
    and o_orderkey = l1.l_orderkey
    and o_orderstatus = 'F'
    and l1.l_receiptdate > l1.l_commitdate
    and l2.l_orderkey = l1.l_orderkey
    and l2.l_suppkey <> l1.l_suppkey
    and s_nationkey = n_nationkey
    and n_name = :1
), L3 as (
  select
    l_orderkey,
    l_suppkey
  from
    lineitem
  where
    l_receiptdate > l_commitdate
)

select
    s_name,
    count(*) as numwait
from
    L1L2 left join L3
on
    L3.l_orderkey = L1L2.l_orderkey
    and L3.l_suppkey <> L1L2.l_suppkey
where
    L3.l_orderkey IS NULL
group by
    s_name
order by
    numwait desc,
    s_name;
