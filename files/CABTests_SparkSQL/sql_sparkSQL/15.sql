with revenue as (
    select
        l_suppkey as supplier_no,
        sum(l_extendedprice * (1 - l_discount)) as total_revenue
    from
        lineitem
    where
            l_shipdate >= date :1
      and l_shipdate < date :1 + interval '3' month
    group by
        l_suppkey)
, max_total_revenue as (
    select
        max(total_revenue) as max_total_revenue
    from
        revenue
)
select
    s_suppkey,
    s_name,
    s_address,
    s_phone,
    total_revenue
from
    supplier,
    revenue,
    max_total_revenue
where
        s_suppkey = supplier_no
  and total_revenue = max_total_revenue
order by
    s_suppkey;
