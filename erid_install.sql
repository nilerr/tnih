disconnect;

connect /@&1 as sysdba;

@@erid_Q1.sql;

disconnect;

connect thrifttime/zet@&1;

@@erid_util.sql

@@erid_Q2.sql;
@@erid_Q3.sql;
@@erid_Q4.sql;
@@erid_Q5.sql;
@@erid_Q6.sql;
@@erid_Q7.sql;
@@erid_Q8.sql;
@@erid_Q9.sql;
@@erid_Q10.sql;

@@erid_Extra.sql;

commit;
