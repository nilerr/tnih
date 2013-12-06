-- Q5
create or replace view infostoc_v as
select mag.site_name, itm.item_name, cat.item_type_name, sto.quantity
  from stoc sto
   join magazin mag on mag.site_id = sto.site_id
   join produs itm on itm.item_id = sto.item_id
    join categorieprodus cat on cat.item_type_id = itm.item_type_id;
   
alter table stoc add (unitary_price number);

create or replace view infostoc_v as
select mag.site_name, itm.item_name, cat.item_type_name, sto.quantity, sto.quantity * sto.unitary_price full_price
  from stoc sto
   join magazin mag on mag.site_id = sto.site_id
   join produs itm on itm.item_id = sto.item_id
    join categorieprodus cat on cat.item_type_id = itm.item_type_id;
