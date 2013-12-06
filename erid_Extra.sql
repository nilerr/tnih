-- Extra
create table inties(site_id number references magazin(site_id),
                    item_id number references produs(item_id),
                    quantity number not null,
                    unit_price number,
                    process_date date
                   );

create or replace trigger inties_new
  after insert on inties for each row
begin
  insert into stoc(site_id, item_id, quantity)
  values (:new.site_id, :new.item_id, :new.quantity);
end;
/

create or replace procedure thrifttime_inout(p_site_id number,
                                             p_item_id number,
                                             p_quantity number,
                                             p_unit_price number,
                                             p_date date)
is
  parameter_fault_ex exception;
  pragma exception_init(parameter_fault_ex, -20000);
begin
  declare
    v_item_id number;
    v_site_id number;
  begin
    select itm.item_id, mag.site_id
      into v_item_id, v_site_id
      from produs itm, magazin mag
     where itm.item_id = p_item_id
       and mag.site_id = p_site_id;
  exception
    when no_data_found then
      raise parameter_fault_ex;
  end;
  
  if p_quantity is null then
    raise parameter_fault_ex;
  end if;

  insert into inties(site_id, item_id, quantity, unit_price, process_date)
  values (p_site_id, p_item_id, p_quantity, p_unit_price, nvl(p_date, sysdate));
exception
  when parameter_fault_ex then
    raise_application_error(-20000, 'Parameters not valid.');
end;
/

create or replace function thrifttime_get_infoval(p_days_no number)
return infoval
pipelined
is
  v_info infoval_rec := infoval_rec(null, null, null, null, null);
begin
  for info in (select mag.site_name,
                      int.process_date,
                      itm.item_name,
                      sum(int.quantity) quantity,
                      sum(int.unit_price * int.quantity) value
                 from inties int
                  join produs itm on itm.item_id = int.item_id
                  join magazin mag on mag.site_id = int.site_id
                where int.process_date > sysdate - nvl(p_days_no, 1)
                group by mag.site_name, int.process_date, itm.item_name
                order by mag.site_name, int.process_date, itm.item_name) loop
    v_info.site_name := info.site_name;
    v_info.process_date := info.process_date;
    v_info.item_name := info.item_name;
    v_info.quantity := info.quantity;
    v_info.value := info.value;
    pipe row (v_info);
  end loop;
end;
/

