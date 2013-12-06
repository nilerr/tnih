-- Q8
-- Nu era extra la Q2?
-- oricum..
create or replace trigger intrari_new
  after insert on intrari for each row
begin
  insert into stoc(site_id, item_id, quantity)
  values (:new.site_id, :new.item_id, :new.quantity);
end;
/

create or replace trigger iesiri_new
  after insert on iesiri for each row
begin
  insert into stoc(site_id, item_id, quantity)
  values (:new.site_id, :new.item_id, -:new.quantity);
end;
/
