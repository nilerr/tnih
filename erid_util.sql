create or replace package thrifttime_util
is

  --function get_random_vocal return varchar2;
  --function get_random_cnsnt return varchar2;
  function so_random(p_letters number) return varchar2;

end thrifttime_util;
/

create or replace package body thrifttime_util
is

  function get_random_vocal
    return varchar2
  is
    v_letter varchar2(1);
  begin
    select substr('aeiou', ceil(dbms_random.value() * 5), 1)
      into v_letter
      from dual;
    return v_letter;
  exception
    when others then
      return null;
  end;

  function get_random_cnsnt
    return varchar2
  is
    v_letter varchar2(1);
  begin
    select substr('bcdfghjklmnpqrstvwxyz', ceil(dbms_random.value() * 21), 1)
      into v_letter
      from dual;
    return v_letter;
  exception
    when others then
      return null;
  end;
  
  -- yes, it's this again
  function so_random(p_letters number)
    return varchar2
  is
    v_out varchar2(128);
    v_letters number;
    v_switch number;
  begin
    if p_letters > 120 then
       v_letters := 120;
    else
      v_letters := nvl(p_letters, 1);
    end if;
  
    v_switch := round(dbms_random.value());
    
    for idx in 1..v_letters loop
      if mod(idx, 2) = v_switch then
        v_out := v_out || get_random_vocal();
      else
        v_out := v_out || get_random_cnsnt();
      end if;
    end loop;
    return upper(substr(v_out, 1, 1)) || substr(v_out, 2);
  end;

end thrifttime_util;
/
