-- Q4
select itm.*
  from produs itm
   left outer join stoc sto on sto.item_id = itm.item_id
 where sto.item_id is null;
 
select itm.*
  from produs itm
 where itm.item_id not in (select sto.item_id
                             from stoc sto);

select itm.*
  from produs itm
   join (select itm.item_id
           from produs itm
          minus
         select sto.item_id
           from stoc sto) ext on ext.item_id = itm.item_id;
