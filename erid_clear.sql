begin
  execute immediate('drop table iesiri');
  execute immediate('drop table intrari');
  begin execute immediate('drop table inties'); exception when others then null; end;
  execute immediate('drop table stoc');
  execute immediate('drop table produs');
  execute immediate('drop table categorieprodus');
  execute immediate('drop table magazin');
  
  execute immediate('drop sequence item_s');
  execute immediate('drop sequence item_type_s');
  execute immediate('drop sequence site_s');
  
  execute immediate('drop type infoval');
  
  commit;
exception
  when others then null;
end;
/

