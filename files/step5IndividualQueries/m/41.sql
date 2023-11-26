-- start query 41 in stream 0 using template query41.tpl
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 993 and 993+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'sandy' or i_color = 'bisque') and 
        (i_units = 'Unknown' or i_units = 'Case') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'aquamarine' or i_color = 'midnight') and
        (i_units = 'Ton' or i_units = 'Bunch') and
        (i_size = 'medium' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'rose' or i_color = 'navy') and
        (i_units = 'Oz' or i_units = 'Box') and
        (i_size = 'economy' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'green' or i_color = 'antique') and
        (i_units = 'Ounce' or i_units = 'Dozen') and
        (i_size = 'extra large' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'tomato' or i_color = 'lace') and 
        (i_units = 'Pound' or i_units = 'Cup') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'lime' or i_color = 'puff') and
        (i_units = 'Tsp' or i_units = 'Pallet') and
        (i_size = 'medium' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'burnished' or i_color = 'navajo') and
        (i_units = 'N/A' or i_units = 'Carton') and
        (i_size = 'economy' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'floral' or i_color = 'moccasin') and
        (i_units = 'Gram' or i_units = 'Each') and
        (i_size = 'extra large' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 41 in stream 0 using template query41.tpl
