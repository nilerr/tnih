-- Q10
create or replace type infoval_rec
as object (site_name varchar2(30),
           process_date date,
           item_name varchar2(50),
           quantity number,
           value number);
/

create or replace type infoval as table of infoval_rec;
/

create or replace function thrifttime_get_infoval(p_days_no number)
return infoval
pipelined
is
  v_info infoval_rec := infoval_rec(null, null, null, null, null);
begin
  for info in (select mag.site_name,
                      int.entry_date,
                      itm.item_name,
                      sum(int.quantity) quantity,
                      sum(int.unit_price * int.quantity) value
                 from intrari int
                  join produs itm on itm.item_id = int.item_id
                  join magazin mag on mag.site_id = int.site_id
                where int.entry_date > sysdate - nvl(p_days_no, 1)
                group by mag.site_name, int.entry_date, itm.item_name
                order by mag.site_name, int.entry_date, itm.item_name) loop
    v_info.site_name := info.site_name;
    v_info.process_date := info.entry_date;
    v_info.item_name := info.item_name;
    v_info.quantity := info.quantity;
    v_info.value := info.value;
    pipe row (v_info);
  end loop;  
end;
/

select *
  from table(thrifttime_get_infoval(10));
