-- Q1
create tablespace eridani37 datafile 'd:\databases\eridani37.dbf' size 100M
  extent management local autoallocate;

create user thrifttime identified by zet default tablespace eridani37;

grant connect to thrifttime;
grant resource to thrifttime;
grant create view to thrifttime;
