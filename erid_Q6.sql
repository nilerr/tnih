-- Q6
create or replace procedure thrifttime_in(p_site_id number,
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

  insert into intrari(site_id, item_id, quantity, unit_price, entry_date)
  values (p_site_id, p_item_id, p_quantity, p_unit_price, nvl(p_date, sysdate));
exception
  when parameter_fault_ex then
    raise_application_error(-20000, 'Parameters not valid.');
end;
/

declare
  v_item_no number;
  v_site_no number;
  v_item_id number;
  v_site_id number;
begin
  for idx in 1..20 loop  

    select count(*)
      into v_item_no
      from produs itm;
    
    v_item_no := ceil(dbms_random.value() * v_item_no);
    
    select ext.item_id
      into v_item_id
      from (select rownum no, itm.item_id
            from produs itm) ext
     where ext.no = v_item_no;
    
    select count(*)
      into v_site_no
      from magazin mag;
    
    v_site_no := ceil(dbms_random.value() * v_site_no);
    
    select ext.site_id
      into v_site_id
      from (select rownum no, mag.site_id
            from magazin mag) ext
     where ext.no = v_site_no;
  
    thrifttime_in(v_site_id, v_item_id, round(dbms_random.value() * 20),  round(dbms_random.value() * 90) + 10, 
                  sysdate - round(dbms_random.value() * 10));
  end loop;
  commit;
end;
/
