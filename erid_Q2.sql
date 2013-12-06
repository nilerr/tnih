-- Q2
create table magazin(site_id number primary key,
                     site_name varchar2(30)
                    );
create table categorieprodus(item_type_id number primary key,
                             item_type_name varchar2(20)
                            );
create table produs(item_id number primary key,
                    -- magazinul aici? de ce?
                    item_type_id number references categorieprodus(item_type_id),
                    item_name varchar2(50)
                   );
create table stoc(site_id number references magazin(site_id),
                  item_id number references produs(item_id),
                  quantity number
                 );
create table intrari(site_id number references magazin(site_id),
                     item_id number references produs(item_id),
                     quantity number not null,
                     unit_price number,
                     entry_date date
                    );
create table iesiri(site_id number references magazin(site_id),
                    item_id number references produs(item_id),
                    quantity number not null,
                    unit_price number,
                    exit_date date
                   );

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

create sequence site_s
  minvalue 1
  start with 1
  increment by 1;

create sequence item_type_s
  minvalue 1
  start with 1
  increment by 1;

create sequence item_s
  minvalue 1
  start with 1
  increment by 1;

commit;
