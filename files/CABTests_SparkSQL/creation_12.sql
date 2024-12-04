--nation
DROP TABLE IF EXISTS nation_text;
CREATE TABLE nation_text (
  n_nationkey  INT,
  n_name       CHAR(25),
  n_regionkey  INT,
  n_comment    VARCHAR(152))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/nation.tbl")
;
drop table if exists nation;
create table nation 
using parquet
as (select * from nation_text)
;
drop table if exists nation_text;

-- region
DROP TABLE IF EXISTS region_text;
CREATE TABLE region_text (
  r_regionkey  INT,
  r_name       CHAR(25),
  r_comment    VARCHAR(152))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/region.tbl")
;
drop table if exists region;
create table region 
using parquet
as (select * from region_text)
;
drop table if exists region_text;

-- supplier
DROP TABLE IF EXISTS supplier_text;
CREATE TABLE supplier_text (
  s_suppkey     INT,
  s_name        CHAR(25),
  s_address     VARCHAR(40),
  s_nationkey   INT,
  s_phone       CHAR(15),
  s_acctbal     DECIMAL(15,2),
  s_comment     VARCHAR(101))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/supplier.tbl")
;
drop table if exists supplier;
create table supplier 
using parquet
as (select * from supplier_text)
;
drop table if exists supplier_text;

-- customer
DROP TABLE IF EXISTS customer_text;
CREATE TABLE customer_text (
  c_custkey     INT,
  c_name        VARCHAR(25),
  c_address     VARCHAR(40),
  c_nationkey   INT,
  c_phone       CHAR(15),
  c_acctbal     DECIMAL(15,2),
  c_mktsegment  CHAR(10),
  c_comment     VARCHAR(117))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/customer.tbl")
;
drop table if exists customer;
create table customer 
using parquet
as (select * from customer_text)
;
drop table if exists customer_text;

-- part
DROP TABLE IF EXISTS part_text;
CREATE TABLE part_text (
  p_partkey     INT,
  p_name        VARCHAR(55),
  p_mfgr        CHAR(25),
  p_brand       CHAR(10),
  p_type        VARCHAR(25),
  p_size        INT,
  p_container   CHAR(10),
  p_retailprice DECIMAL(15,2),
  p_comment     VARCHAR(23))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/part.tbl")
;
drop table if exists part;
create table part 
using parquet
as (select * from part_text)
;
drop table if exists part_text;

-- partsupp
DROP TABLE IF EXISTS partsupp_text;
CREATE TABLE partsupp_text (
  ps_partkey     INT,
  ps_suppkey     INT,
  ps_availqty    INT,
  ps_supplycost  DECIMAL(15,2),
  ps_comment     VARCHAR(199))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/partsupp.tbl")
;
drop table if exists partsupp;
create table partsupp 
using parquet
as (select * from partsupp_text)
;
drop table if exists partsupp_text;

-- orders
DROP TABLE IF EXISTS orders_text;
CREATE TABLE orders_text (
  o_orderkey       INT,
  o_custkey        INT,
  o_orderstatus    CHAR(1),
  o_totalprice     DECIMAL(15,2),
  o_orderdate      DATE,
  o_orderpriority  CHAR(15),
  o_clerk          CHAR(15),
  o_shippriority   INT,
  o_comment        VARCHAR(79))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/orders.tbl")
;
drop table if exists orders;
create table orders 
using parquet
as (select * from orders_text)
;
drop table if exists orders_text;

-- lineitem
DROP TABLE IF EXISTS lineitem_text;
CREATE TABLE lineitem_text (
  l_orderkey          INT,
  l_partkey           INT,
  l_suppkey           INT,
  l_linenumber        INT,
  l_quantity          DECIMAL(15,2),
  l_extendedprice     DECIMAL(15,2),
  l_discount          DECIMAL(15,2),
  l_tax               DECIMAL(15,2),
  l_returnflag        CHAR(1),
  l_linestatus        CHAR(1),
  l_shipdate          DATE,
  l_commitdate        DATE,
  l_receiptdate       DATE,
  l_shipinstruct      CHAR(25),
  l_shipmode          CHAR(10),
  l_comment           VARCHAR(44))
USING csv
OPTIONS(header "false", delimiter "|", path "file:///root/home/spark/mtdds/tpch/12/lineitem.tbl")
;
drop table if exists lineitem;
create table lineitem 
using parquet
as (select * from lineitem_text)
;
drop table if exists lineitem_text;
