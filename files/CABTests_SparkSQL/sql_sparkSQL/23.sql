with r1 as
   (select
       l_orderkey,
       sum(L_QUANTITY * P_RETAILPRICE * (1+L_TAX) * (1-L_DISCOUNT)) as total_cost
    from lineitem, part
    where P_PARTKEY = L_PARTKEY
    group by l_orderkey)
insert into orders (
select o_orderkey + 8,
       o_custkey,
       o_orderstatus,
       total_cost,
       o_orderdate,
       o_orderpriority,
       o_clerk,
       o_shippriority,
       o_comment
from orders, r1
where o_orderkey >= :1 and o_orderkey < :2
and l_orderkey = o_orderkey
);
:split:
delete from orders where o_orderkey >= :1 and o_orderkey < :2 and mod(o_orderkey, 32) between :3 and :4;
