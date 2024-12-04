with r1 as
    (select
        ps_partkey, min(ps_supplycost) as min_ps_supplycost
    from
        partsupp,
        supplier,
        nation,
        region
    where
      s_suppkey = ps_suppkey
      and s_nationkey = n_nationkey
      and n_regionkey = r_regionkey
      and r_name = :3
    group by ps_partkey)
select
    s_acctbal,
    s_name,
    n_name,
    p_partkey,
    p_mfgr,
    s_address,
    s_phone,
    s_comment
from
    region,
    nation,
    supplier,
    partsupp,
    part,
    r1
where
  s_suppkey = ps_suppkey
  and p_size = :1
  and p_type like '%' || :2
  and s_nationkey = n_nationkey
  and n_regionkey = r_regionkey
  and r_name = :3
  and ps_supplycost = min_ps_supplycost
  and p_partkey = r1.ps_partkey
order by
    s_acctbal desc,
    n_name,
    s_name,
    p_partkey
limit 100;
