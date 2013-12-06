-- Q3
begin
  for site_idx in 1..2 loop
    insert into magazin(site_id, site_name)
    values (site_s.nextval, thrifttime_util.so_random(5));
    
    for type_idx in 1..3 loop
      insert into categorieprodus(item_type_id, item_type_name)
      values (item_type_s.nextval, thrifttime_util.so_random(3));
      
      -- create two items per category
      for item_idx in 1..2 loop
        insert into produs(item_id, item_type_id, item_name)
        values (item_s.nextval, item_type_s.currval, thrifttime_util.so_random(round(dbms_random.value() * 4) + 3));
      end loop; -- end item
      
      -- and just stoc one
      insert into stoc(site_id, item_id, quantity)
      values (site_s.currval, item_s.currval - round(dbms_random.value()), round(dbms_random.value() * 25));

    end loop; -- end type
  end loop; -- end site
  
  commit;
end;
/
