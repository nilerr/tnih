-- Q9
select mag.site_name, itm.item_name, sum(int.quantity)
  from intrari int
   join magazin mag on mag.site_id = int.site_id
   join produs itm on itm.item_id = int.site_id
 where int.entry_date > sysdate - 10
 group by mag.site_name, itm.item_name;

select mag.site_name, itm.item_name, sum(ext.quantity)
  from iesiri ext
   join magazin mag on mag.site_id = ext.site_id
   join produs itm on itm.item_id = ext.site_id
 where ext.exit_date > sysdate - 10
 group by mag.site_name, itm.item_name;
